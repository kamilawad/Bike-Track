import { ConnectedSocket, MessageBody, SubscribeMessage, WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
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
        for (const chat of chats) {
            const otherUserId = chat.user1._id.toString() === userId ? chat.user2._id.toString() : chat.user1._id.toString();
            client.leave(`chat-${chat._id}`);
            client.to(`chat-${chat._id}`).emit('userDisconnected', { userId, otherUserId });
        }
    }

    @SubscribeMessage('sendMessage')
    async handleSendMessage(@MessageBody() data: { chatId: string; content: string }, @ConnectedSocket() client: Socket) {
        const senderId = this.getUserIdFromClient(client);
        const { chatId, content } = data;

        const message = await this.chatService.sendMessage(chatId, senderId, content);
        const chat = await this.chatService.getChatById(chatId);
        const recipientId = chat.user1._id.toString() === senderId ? chat.user2._id.toString() : chat.user1._id.toString();
    }

    private getUserIdFromClient(client: Socket): string {
        return client.handshake.auth.userId;
    }
}