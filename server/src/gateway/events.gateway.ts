import { OnModuleInit } from "@nestjs/common";
import { MessageBody, SubscribeMessage, WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Server, Socket } from 'socket.io';

@WebSocketGateway( {cors:{ origin: '*', }} )
export class EventsGateway implements OnModuleInit{
    @WebSocketServer()
    server: Server;
    connectedUsers: Map<string, string> = new Map();

    onModuleInit() {
        this.server.on('connection', (socket)=>{
            console.log(socket.id);
            console.log('connected');

            this.handleConnection(socket);
        })
    }

    handleConnection(client: Socket) {
        client.on('setUserId', (userId: string) => {
          this.connectedUsers.set(userId, client.id);
        });
      
        client.on('disconnect', () => {
          const userId = Array.from(this.connectedUsers.entries()).find(([_, socketId]) => socketId === client.id)?.[0];
          if (userId) {
            this.connectedUsers.delete(userId);
          }
        });
    }

    @SubscribeMessage('message')
    //handleMessage(client: any, payload: any){
    onNewMessage(@MessageBody() body: any) {
        console.log(body);
        this.server.emit('onMessage', {
            msg: 'new message',
            content: body,
        });
        //return 'hello';
    }
}