import { WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Server, Socket } from 'socket.io';

@WebSocketGateway({ namespace: '/group-chat' })
export class GroupChatGateway {
    @WebSocketServer() server: Server;

    private connectedUsers = new Map<string, Socket>();

    constructor(private readonly groupChatService: GroupChatService) {}
}