import { Body, Controller, Delete, Get, Param, Post, Put, Request, UseGuards, UsePipes, ValidationPipe } from "@nestjs/common";
import { GroupChatService } from "./group-chat.service";
import { AuthGuard } from "@nestjs/passport";
import { CreateGroupChatDto } from "./dto/create-group-chat.dto";
import { UpdateGroupChatDto } from "./dto/update-group-chat.dto";
import { SendMessageDto } from "src/chats/dto/send-message.dto";
import { AddMemberDto } from "./dto/add-member.dto";

@Controller('groups')
@UseGuards(AuthGuard("jwt"))
export class GroupChatController {
    constructor(private readonly groupChatService: GroupChatService) {}

    @Post()
    @UsePipes(new ValidationPipe())
    createGroupChat( @Request() req, @Body() createGroupChatDto: CreateGroupChatDto) {
    return this.groupChatService.createGroupChat(createGroupChatDto, req.user._id);
    }

    @Get(":id")
    getGroupChatById(@Param("id") id: string) {
    return this.groupChatService.getGroupChatById(id);
    }

    @Put(":id")
    @UsePipes(new ValidationPipe())
    updateGroupChat(@Param("id") id: string,@Body() updateGroupChatDto: UpdateGroupChatDto) {
    return this.groupChatService.updateGroupChat(id, updateGroupChatDto);
    }

    @Delete(":id")
    deleteGroupChat(@Param("id") id: string) {
    return this.groupChatService.deleteGroupChat(id);
    }

    @Post(":id/message")
    @UsePipes(new ValidationPipe())
    sendMessage(@Param("id") id: string,@Request() req,@Body() sendMessageDto: SendMessageDto) {
        const senderId = req.user._id;
        const { content } = sendMessageDto;
        return this.groupChatService.sendMessage(id, senderId, content);
    }

    @Post(":id/join")
    joinGroupChat(@Param("id") id: string, @Request() req) {
        const userId = req.user._id;
        return this.groupChatService.joinGroupChat(id, userId);
    }

    @Post(":id/leave")
    leftGroupChat(@Param("id") id: string, @Request() req) {
        const userId = req.user._id;
        return this.groupChatService.leftGroupChat(id, userId);
    }

    @Post(":id/addMember")
    @UsePipes(new ValidationPipe())
    addMember(@Param("id") id: string, @Request() req, @Body() addMemberDto: AddMemberDto) {
        const adminId = req.user._id;
        const { memberId } = addMemberDto;
        return this.groupChatService.addMember(id, memberId, adminId);
    }
}