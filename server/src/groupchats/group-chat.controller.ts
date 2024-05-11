import { Body, Controller, Delete, Get, Param, Post, Put, Request, UseGuards } from "@nestjs/common";
import { GroupChatService } from "./group-chat.service";
import { AuthGuard } from "@nestjs/passport";
import { CreateGroupChatDto } from "./dto/create-group-chat.dto";
import { UpdateGroupChatDto } from "./dto/update-group-chat.dto";
import { SendMessageDto } from "src/chats/dto/send-message.dto";

@Controller()
@UseGuards(AuthGuard("jwt"))
export class GroupChatController {
    constructor(private readonly groupChatService: GroupChatService) {}

    @Post()
    createGroupChat( @Request() req, @Body() createGroupChatDto: CreateGroupChatDto) {
    return this.groupChatService.createGroupChat(createGroupChatDto, req.user._id);
    }

    @Get("/:id")
    getGroupChatById(@Param("id") id: string) {
    return this.groupChatService.getGroupChatById(id);
    }

    @Put("/:id")
    updateGroupChat(@Param("id") id: string,@Body() updateGroupChatDto: UpdateGroupChatDto) {
    return this.groupChatService.updateGroupChat(id, updateGroupChatDto);
    }

    @Delete("/:id")
    deleteGroupChat(@Param("id") id: string) {
    return this.groupChatService.deleteGroupChat(id);
    }

    @Post("/:id/message")
    sendMessage(@Param("id") id: string,@Request() req,@Body() sendMessageDto: SendMessageDto) {
        const senderId = req.user._id;
        const { content } = sendMessageDto;
        return this.groupChatService.sendMessage(id, senderId, content);
    }
}