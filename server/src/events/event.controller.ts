import { Controller, Param, UseGuards, Request, Post } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { EventService } from "./event.service";

@Controller('events')
@UseGuards(AuthGuard('jwt'))
export class EventController {
    constructor(private readonly eventService: EventService) {}

    @Post(':id/join')
    joinEvent(@Param('id') id: string, @Request() req) {
        const userId = req.user._id;
        return this.eventService.joinEvent(id, userId);
    }
}