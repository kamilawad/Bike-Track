import { MessageBody, SubscribeMessage, WebSocketGateway } from "@nestjs/websockets";
import { Server } from 'socket.io'

@WebSocketGateway()
export class ChatGateway {
    server: Server;

    @SubscribeMessage('newMessage')
    onNewMessage(@MessageBody() body: any) {
        //log message body in the console
        console.log(body);
    }
}