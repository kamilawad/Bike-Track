import { WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Server } from 'socket.io';

@WebSocketGateway({ namespace: '/group-chat' })
export class GroupChatGateway {
    @WebSocketServer() server: Server;
}