import { WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Server, Socket } from 'socket.io';
import { ChatService } from "./chat.service";

@WebSocketGateway({ namespace: '/chat' })
export class ChatGateway {
    @WebSocketServer()
    server: Server;

    private connectedUsers = new Map<string, Socket>();

    constructor(private readonly chatService: ChatService) {}

    async handleConnection(client: Socket) {}
}