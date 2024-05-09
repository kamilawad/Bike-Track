import { MessageBody, SubscribeMessage, WebSocketGateway } from "@nestjs/websockets";

@WebSocketGateway()
export class ChatGateway {
    @SubscribeMessage('newMessage')
    onNewMessage(@MessageBody() body: any) {
        
    }
}