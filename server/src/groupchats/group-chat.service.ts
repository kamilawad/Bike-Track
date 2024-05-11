import { Injectable, NotFoundException } from "@nestjs/common";
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
            throw new NotFoundException("admin not found");
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
            throw new NotFoundException("group chat or sender not found");
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

    async joinGroupChat(groupChatId: string, userId: string): Promise<GroupChat> {
        const groupChat = await this.groupChatModel.findById(groupChatId);
        const user = await this.userModel.findById(userId);
    
        if (!groupChat || !user) {
            throw new NotFoundException("group chat or user not found");
        }

        if (groupChat.members.some((member) => member._id.toString() === user._id.toString())) {
            throw new Error("user is already a member of this group chat");
        }
    
        groupChat.members.push(user);
        await groupChat.save();
    
        return groupChat;
    }

    async leftGroupChat(groupChatId: string, userId: string): Promise<GroupChat> {
        const groupChat = await this.groupChatModel.findById(groupChatId);
        const user = await this.userModel.findById(userId);
    
        if (!groupChat || !user) {
            throw new NotFoundException("group chat or user not found");
        }

        if (groupChat.members.some((member) => member._id.toString() === user._id.toString())) {
            throw new Error("user is already a member of this group chat");
        }

        groupChat.members = groupChat.members.filter(
            (member) => member._id.toString() !== user._id.toString());
      
        await groupChat.save();
    
        return groupChat;
    }

    async addMember( groupChatId: string, memberId: string, adminId: string): Promise<GroupChat> {
        const groupChat = await this.groupChatModel.findById(groupChatId);
        const member = await this.userModel.findById(memberId);
        const admin = await this.userModel.findById(adminId);
    
        if (!groupChat || !member || !admin) {
            throw new Error("group chat, member, or admin not found");
        }
    
        if (!groupChat.admins.some((a) => a._id.toString() === admin._id.toString())) {
            throw new Error("user is not an admin of this group chat");
        }

        if (groupChat.members.some((m) => m._id.toString() === member._id.toString())) {
            throw new Error("member already exists in the group chat");
        }
    
        groupChat.members.push(member);
        await groupChat.save();
    
        return groupChat;
    }
}