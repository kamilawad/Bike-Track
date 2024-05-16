import { ConnectedSocket, SubscribeMessage, WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Server, Socket } from 'socket.io';

@WebSocketGateway({
    namespace: '/live-tracking',
    cors: {
        origin: '*',
    },
})
export class LiveTrackingGateway {
    @WebSocketServer() server: Server;
    private connectedUsers = new Map<string, Socket>();

    @SubscribeMessage('startTracking')
    handleStartTracking(@ConnectedSocket() client: Socket) {
        const userId = this.getUserIdFromClient(client);
        this.connectedUsers.set(userId, client);
        console.log(`User ${userId} started tracking`);
    }

    private getUserIdFromClient(client: Socket): string {
        return client.handshake.auth.userId;
    }
}