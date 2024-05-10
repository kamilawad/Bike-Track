import { Body, Request, Controller, Post, UseGuards } from "@nestjs/common";
import { ChatService } from "./chat.service";
import { AuthGuard } from "@nestjs/passport";
import { CreateChatDto } from "./dto/create-chat.dto";

@Controller('chats')
@UseGuards(AuthGuard("jwt"))
export class ChatController {
    constructor(private readonly chatService: ChatService) {}

    @Post()
    createChat(@Request() req, @Body() createChatDto: CreateChatDto) {
        createChatDto.id1 = req.user.id;
        return this.chatService.createChat(createChatDto);
    }
}