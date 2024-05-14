import { WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Server, Socket } from 'socket.io';
import { GroupChatService } from "./group-chat.service";

@WebSocketGateway({ namespace: '/group-chat' })
export class GroupChatGateway {
    @WebSocketServer() server: Server;

    private connectedUsers = new Map<string, Socket>();

    constructor(private readonly groupChatService: GroupChatService) {}

    private getUserIdFromClient(client: Socket): string {
        return client.handshake.auth.userId;
    }
}