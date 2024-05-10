import { Body, Request, Controller, Post, UseGuards, Param, Get } from "@nestjs/common";
import { ChatService } from "./chat.service";
import { AuthGuard } from "@nestjs/passport";
import { CreateChatDto } from "./dto/create-chat.dto";
import { SendMessageDto } from "./dto/send-message.dto";

@Controller('chats')
@UseGuards(AuthGuard("jwt"))
export class ChatController {
    constructor(private readonly chatService: ChatService) {}

    @Post()
    createChat(@Request() req, @Body() createChatDto: CreateChatDto) {
        createChatDto.id1 = req.user.id;
        return this.chatService.createChat(createChatDto);
    }

    @Get(":id")
    getChatById(@Param("id") id: string) {
        return this.chatService.getChatById(id);
    }

    @Post(":id/send-message")
    sendMessage(@Request() req, @Param("id") chatId: string, @Body() sendMessageDto: SendMessageDto) {
        return this.chatService.sendMessage(chatId, req.user.id, sendMessageDto.content);
    }
}