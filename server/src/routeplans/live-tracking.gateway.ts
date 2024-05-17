import { InjectModel } from "@nestjs/mongoose";
import { ConnectedSocket, SubscribeMessage, WebSocketGateway, WebSocketServer, MessageBody } from "@nestjs/websockets";
import { Model } from "mongoose";
import { Server, Socket } from 'socket.io';
import { User } from "src/schemas/user.schema";

@WebSocketGateway({
    namespace: '/live-tracking',
    cors: {
        origin: '*',
    },
})
export class LiveTrackingGateway {
    constructor(
        @InjectModel(User.name)
        private userModel: Model<User>,
    ) {}
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
    async handleLocationUpdate(@MessageBody() data: { latitude: number; longitude: number; userName: string },@ConnectedSocket() client: Socket,) {
        const userId = this.getUserIdFromClient(client);
        const { latitude, longitude, userName } = data;

        this.server.emit('locationUpdate', {
            userId,
            latitude,
            longitude,
            userName,
        });
    }


    private getUserIdFromClient(client: Socket): string {
        return client.handshake.auth.userId;
    }
}