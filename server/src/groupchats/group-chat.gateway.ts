import { ConnectedSocket, MessageBody, SubscribeMessage, WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Server, Socket } from 'socket.io';
import { GroupChatService } from "./group-chat.service";

@WebSocketGateway({ namespace: '/group-chat', cors: { origin: '*', }, })
export class GroupChatGateway {
  @WebSocketServer() server: Server;
  private connectedUsers = new Map<string, Set<string>>();

  constructor(private readonly groupChatService: GroupChatService) {}

  async handleConnection(client: Socket) {
    const userId = this.getUserIdFromClient(client);
    if (!this.connectedUsers.has(userId)) {
      this.connectedUsers.set(userId, new Set());
    }
    console.log(`User ${userId} connected`);
    const groupChats = await this.groupChatService.getUserGroupChats(userId);
    for (const groupChat of groupChats) {
      const groupChatId = groupChat._id.toString();
      this.connectedUsers.get(userId)?.add(groupChatId);
      client.join(`group-chat-${groupChatId}`);
      this.server.to(`group-chat-${groupChatId}`).emit('userJoined', { userId });
    }
  }

  async handleDisconnect(client: Socket) {
    const userId = this.getUserIdFromClient(client);
    if (this.connectedUsers.has(userId)) {
      const groupChats = this.connectedUsers.get(userId);
      for (const groupChatId of groupChats!) {
        client.leave(`group-chat-${groupChatId}`);
        this.server.to(`group-chat-${groupChatId}`).emit('userLeft', { userId });
      }
      this.connectedUsers.delete(userId);
    }
  }

  @SubscribeMessage('sendGroupMessage')
  async handleSendGroupMessage(
    @MessageBody() data: { groupChatId: string; content: string },
    @ConnectedSocket() client: Socket
  ) {
    const senderId = this.getUserIdFromClient(client);
    const { groupChatId, content } = data;
    const message = await this.groupChatService.sendMessage(groupChatId, senderId, content);
    this.server.to(`group-chat-${groupChatId}`).emit('newGroupMessage', message);
  }

  private getUserIdFromClient(client: Socket): string {
    return client.handshake.auth.userId;
  }
}