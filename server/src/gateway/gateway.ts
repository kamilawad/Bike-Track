import { OnModuleInit } from "@nestjs/common";
import { MessageBody, SubscribeMessage, WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Server } from 'socket.io'

@WebSocketGateway()
export class ChatGateway implements OnModuleInit{
    @WebSocketServer()
    server: Server;

    onModuleInit() {
        
    }

    @SubscribeMessage('newMessage')
    onNewMessage(@MessageBody() body: any) {
        //log message body in the console
        console.log(body);
    }
}