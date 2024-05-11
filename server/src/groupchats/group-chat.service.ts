import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { GroupChat } from "src/schemas/groupchat.schema";
import { Message } from "src/schemas/message.schema";
import { User } from "src/schemas/user.schema";
import { CreateGroupChatDto } from "./dto/create-group-chat.dto";

@Injectable()
export class GroupChatService {
    constructor(
        @InjectModel(GroupChat.name) private groupChatModel: Model<GroupChat>,
        @InjectModel(User.name) private userModel: Model<User>,
        @InjectModel(Message.name) private messageModel: Model<Message>
    ) {}

    async createGroupChat(
        createGroupChatDto: CreateGroupChatDto, adminId: string): Promise<GroupChat> {
        const { name, memberIds } = createGroupChatDto;

        const members = await this.userModel.find({ _id: { $in: memberIds } });
        const admin = await this.userModel.findById(adminId);

        if (!admin) {
            throw new Error("admin not found");
        }

        const groupChat = new this.groupChatModel({
            name,
            members,
            admins: [admin],
            messages: [],
        });

        return groupChat.save();
    }
}