import { Controller, UseGuards } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";

@Controller('events')
@UseGuards(AuthGuard('jwt'))
export class EventController {}