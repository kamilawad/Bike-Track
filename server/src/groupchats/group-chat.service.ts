import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { GroupChat } from "src/schemas/groupchat.schema";
import { Message } from "src/schemas/message.schema";
import { User } from "src/schemas/user.schema";

@Injectable()
export class GroupChatService {
    constructor(
        @InjectModel(GroupChat.name) private groupChatModel: Model<GroupChat>,
        @InjectModel(User.name) private userModel: Model<User>,
        @InjectModel(Message.name) private messageModel: Model<Message>
    ) {}
}