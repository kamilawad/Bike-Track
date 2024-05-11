import { Controller, UseGuards } from "@nestjs/common";
import { GroupChatService } from "./group-chat.service";
import { AuthGuard } from "@nestjs/passport";

@Controller()
@UseGuards(AuthGuard("jwt"))
export class GroupChatController {
    constructor(private readonly groupChatService: GroupChatService) {}
}