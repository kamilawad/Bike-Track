import { ConnectedSocket, MessageBody, SubscribeMessage, WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
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
        console.log(`User ${userId} connected`);

        const groupChats = await this.groupChatService.getUserGroupChats(userId);
        for (const groupChat of groupChats) {
            client.join(`group-chat-${groupChat._id}`);
            this.server.to(`group-chat-${groupChat._id}`).emit('userJoined', { userId });
        }
    }

    async handleDisconnect(client: Socket) {
        const userId = this.getUserIdFromClient(client);
        this.connectedUsers.delete(userId);

        const groupChats = await this.groupChatService.getUserGroupChats(userId);
        for (const groupChat of groupChats) {
            client.leave(`group-chat-${groupChat._id}`);
            this.server.to(`group-chat-${groupChat._id}`).emit('userLeft', { userId });
        }
    }

    @SubscribeMessage('sendGroupMessage')
    async handleSendGroupMessage( @MessageBody() data: { groupChatId: string; content: string }, @ConnectedSocket() client: Socket) {
        const senderId = this.getUserIdFromClient(client);
        const { groupChatId, content } = data;

        const message = await this.groupChatService.sendMessage(groupChatId, senderId, content);

        this.server.to(`group-chat-${groupChatId}`).emit('newGroupMessage', message);
    }

    private getUserIdFromClient(client: Socket): string {
        return client.handshake.auth.userId;
    }
}