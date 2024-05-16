import { WebSocketGateway } from "@nestjs/websockets";

@WebSocketGateway({ namespace: '/live-tracking' })
export class LiveTrackingGateway {}