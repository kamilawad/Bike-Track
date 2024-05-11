import { Controller } from "@nestjs/common";
import { GroupChatService } from "./group-chat.service";

@Controller()
export class GroupChatController {
    constructor(private readonly groupChatService: GroupChatService) {}
}