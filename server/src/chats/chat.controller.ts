import { Body, Request, Controller, Post, UseGuards, Param, Get, Put, Delete, UsePipes, ValidationPipe } from "@nestjs/common";
import { ChatService } from "./chat.service";
import { AuthGuard } from "@nestjs/passport";
import { CreateChatDto } from "./dto/create-chat.dto";
import { SendMessageDto } from "./dto/send-message.dto";
import { UpdateChatDto } from "./dto/update-chat.dto";

@Controller('chats')
@UseGuards(AuthGuard("jwt"))
export class ChatController {
    constructor(private readonly chatService: ChatService) {}

    @Post()
    @UsePipes(new ValidationPipe())
    async createChat(@Request() req, @Body() createChatDto: CreateChatDto) {
        const user1Id = req.user.id;
        const user2Id = createChatDto.user2Id;

    return this.chatService.createChat(user1Id, user2Id);
    }

    @Get(":id")
    getChatById(@Param("id") id: string) {
        return this.chatService.getChatById(id);
    }

    @Put(":id")
    updateChat(@Param("id") id: string, @Body() updateChatDto: UpdateChatDto) {
        return this.chatService.updateChat(id, updateChatDto);
    }

    @Delete(":id")
    deleteChat(@Param("id") id: string) {
        return this.chatService.deleteChat(id);
    }

    @Post(":id/send-message")
    @UsePipes(new ValidationPipe())
    sendMessage(@Request() req, @Param("id") chatId: string, @Body() sendMessageDto: SendMessageDto) {
        return this.chatService.sendMessage(chatId, req.user.id, sendMessageDto.content);
    }
}