import { WebSocketGateway } from "@nestjs/websockets";

@WebSocketGateway({ namespace: '/group-chat' })
export class GroupChatGateway {}