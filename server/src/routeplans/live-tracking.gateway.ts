import { ConnectedSocket, SubscribeMessage, WebSocketGateway, WebSocketServer, MessageBody } from "@nestjs/websockets";
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

    @SubscribeMessage('stopTracking')
    handleStopTracking(@ConnectedSocket() client: Socket) {
        const userId = this.getUserIdFromClient(client);
        this.connectedUsers.delete(userId);
        console.log(`User ${userId} stopped tracking`);
    }

    @SubscribeMessage('locationUpdate')
    handleLocationUpdate(@MessageBody() data: { latitude: number; longitude: number }, @ConnectedSocket() client: Socket) {
        const userId = this.getUserIdFromClient(client);
        const { latitude, longitude } = data;

        this.server.emit('locationUpdate', { userId, latitude, longitude });
    }


    private getUserIdFromClient(client: Socket): string {
        return client.handshake.auth.userId;
    }
}