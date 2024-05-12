import { WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Server, Socket } from 'socket.io';
import { ChatService } from "./chat.service";

@WebSocketGateway({ namespace: '/chat' })
export class ChatGateway {
    @WebSocketServer()
    server: Server;

    private connectedUsers = new Map<string, Socket>();

    constructor(private readonly chatService: ChatService) {}

    async handleConnection(client: Socket) {
        try {
            console.log('A new connection was established.');
            console.log('Client ID:', client.id);
        } catch (error) {
            console.error('An error occurred during connection:', error);
        }

        const userId = this.getUserIdFromClient(client);
        this.connectedUsers.set(userId, client);

        const chats = await this.chatService.getUserChats(userId);
        for (const chat of chats) {
            const otherUserId = chat.user1._id.toString() === userId ? chat.user2._id.toString() : chat.user1._id.toString();
            client.join(`chat-${chat._id}`);
            client.to(`chat-${chat._id}`).emit('userConnected', { userId, otherUserId });
        }
    }

    async handleDisconnect(client: Socket) {
        const userId = this.getUserIdFromClient(client);
        this.connectedUsers.delete(userId);

        const chats = await this.chatService.getUserChats(userId);
    }

    async handleSendMessage() {}

    private getUserIdFromClient(client: Socket): string {
        return client.handshake.auth.userId;
    }
}