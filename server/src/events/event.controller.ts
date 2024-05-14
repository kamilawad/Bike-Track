import { Controller, UseGuards } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { EventService } from "./event.service";

@Controller('events')
@UseGuards(AuthGuard('jwt'))
export class EventController {
    constructor(private readonly eventService: EventService) {}
}