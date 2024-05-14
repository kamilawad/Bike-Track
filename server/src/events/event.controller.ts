import { Controller, Param, UseGuards, Request, Post, Body } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { EventService } from "./event.service";
import { CreateEventDto } from "./dto/create-event.dto";

@Controller('events')
@UseGuards(AuthGuard('jwt'))
export class EventController {
    constructor(private readonly eventService: EventService) {}

    @Post()
    create(@Body() createEventDto: CreateEventDto, @Request() req) {
        const userId = req.user._id;
        return this.eventService.createEvent(createEventDto, userId);
    }

    @Post(':id/join')
    joinEvent(@Param('id') id: string, @Request() req) {
        const userId = req.user._id;
        return this.eventService.joinEvent(id, userId);
    }
}