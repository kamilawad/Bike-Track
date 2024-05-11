import { Body, Controller, Post, Request, UseGuards } from "@nestjs/common";
import { GroupChatService } from "./group-chat.service";
import { AuthGuard } from "@nestjs/passport";
import { CreateGroupChatDto } from "./dto/create-group-chat.dto";

@Controller()
@UseGuards(AuthGuard("jwt"))
export class GroupChatController {
    constructor(private readonly groupChatService: GroupChatService) {}

    @Post()
    createGroupChat( @Request() req, @Body() createGroupChatDto: CreateGroupChatDto) {
        return this.groupChatService.createGroupChat(createGroupChatDto, req.user._id);
    }
}