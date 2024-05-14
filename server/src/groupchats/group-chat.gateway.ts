import { WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Server, Socket } from 'socket.io';
import { GroupChatService } from "./group-chat.service";

@WebSocketGateway({ namespace: '/group-chat' })
export class GroupChatGateway {
    @WebSocketServer() server: Server;

    private connectedUsers = new Map<string, Socket>();

    constructor(private readonly groupChatService: GroupChatService) {}

    async handleConnection(client: Socket) {
        const userId = this.getUserIdFromClient(client);
        this.connectedUsers.set(userId, client);

        const groupChats = await this.groupChatService.getUserGroupChats(userId);
        for (const groupChat of groupChats) {
            client.join(`group-chat-${groupChat._id}`);
        }
    }

    async handleDisconnect(client: Socket) {
        const userId = this.getUserIdFromClient(client);
        this.connectedUsers.delete(userId);

        const groupChats = await this.groupChatService.getUserGroupChats(userId);
        for (const groupChat of groupChats) {
            client.leave(`group-chat-${groupChat._id}`);
        }
    }

    private getUserIdFromClient(client: Socket): string {
        return client.handshake.auth.userId;
    }
}