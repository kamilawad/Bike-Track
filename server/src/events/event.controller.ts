import { Controller, Param, UseGuards, Request, Post, Body, UseInterceptors, UploadedFile, Put } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { EventService } from "./event.service";
import { CreateEventDto } from "./dto/create-event.dto";

@Controller('events')
@UseGuards(AuthGuard('jwt'))
export class EventController {
    constructor(private readonly eventService: EventService) {}

    @Post()
    createEvent(@Body() createEventDto: CreateEventDto, @Request() req) {
        const organizerId = req.user.id;
        return this.eventService.createEvent(createEventDto, organizerId);
    }

    @Put('/:eventId/members/:memberId')
    async addMember(@Param('eventId') eventId: string, @Param('memberId') memberId: string) {
        return this.eventService.addMember(eventId, memberId);
    }

    @Post(':id/join')
    joinEvent(@Param('id') id: string, @Request() req) {
        const userId = req.user.id;
        return this.eventService.joinEvent(id, userId);
    }
}