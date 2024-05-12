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
    }

    async handleDisconnect(client: Socket) {}

    async handleSendMessage() {}

    private getUserIdFromClient(client: Socket): string {
        return client.handshake.auth.userId;
    }
}