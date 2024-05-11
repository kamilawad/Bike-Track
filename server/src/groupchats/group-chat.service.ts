import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { GroupChat } from "src/schemas/groupchat.schema";
import { Message } from "src/schemas/message.schema";
import { User } from "src/schemas/user.schema";
import { CreateGroupChatDto } from "./dto/create-group-chat.dto";
import { UpdateGroupChatDto } from "./dto/update-group-chat.dto";

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

        const existingGroupChat = await this.groupChatModel.findOne({ name });
        if (existingGroupChat) {
            return existingGroupChat;
        }

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

    async getGroupChatById(id: string): Promise<GroupChat> {
        return this.groupChatModel
            .findById(id)
            .populate('members', '_id fullName')
            .populate('admins', '_id fullName')
            //.populate('messages', 'content sentAt sender')
            .populate({
                path: 'messages',
                options: { sort: { sentAt: 1 } },
            });
    }

    async updateGroupChat(id: string, updateGroupChatDto: UpdateGroupChatDto): Promise<GroupChat> {
        return this.groupChatModel.findByIdAndUpdate(id, updateGroupChatDto, { new: true });
    }

    async deleteGroupChat(id: string): Promise<GroupChat> {
        return this.groupChatModel.findByIdAndDelete(id);
    }

    async sendMessage(groupChatId: string, senderId: string, content: string): Promise<Message> {
        const groupChat = await this.groupChatModel.findById(groupChatId);
        const sender = await this.userModel.findById(senderId);
    
        if (!groupChat || !sender) {
          throw new Error("group chat or sender not found");
        }
    
        const message = new this.messageModel({
          sender,
          content,
          sentAt: new Date(),
        });
    
        const savedMessage = await message.save();
        groupChat.messages.push(savedMessage);
        await groupChat.save();
    
        return savedMessage;
      }
}