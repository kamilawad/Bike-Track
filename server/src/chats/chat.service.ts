import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { Chat } from "src/schemas/chat.schema";
import { Message } from "src/schemas/message.schema";
import { User } from "src/schemas/user.schema";
import { UpdateChatDto } from "./dto/update-chat.dto";
import { EventsGateway } from "src/gateway/events.gateway";

@Injectable()
export class ChatService {
    constructor(
        private eventGateway: EventsGateway,
        @InjectModel(Chat.name) private chatModel: Model<Chat>,
        @InjectModel(User.name) private userModel: Model<User>,
        @InjectModel(Message.name) private messageModel: Model<Message>
    ) {}

    async createChat(user1Id: string, user2Id: string): Promise<Chat> {
        const existingChat = await this.chatModel.findOne({
            $or: [
                { user1: user1Id, user2: user2Id },
                { user1: user2Id, user2: user1Id },
            ],
        });
      
        if (existingChat) {
          return existingChat;
        }
      
        const user1 = await this.userModel.findById(user1Id);
        const user2 = await this.userModel.findById(user2Id);
      
        if (!user1 || !user2) {
            throw new Error("user not found");
        }
      
        const chat = new this.chatModel({ user1, user2, messages: [] });
        const savedChat = await chat.save();
      
        user1.individualChats.push(savedChat._id);
        user2.individualChats.push(savedChat._id);
      
        await user1.save();
        await user2.save();
      
        return savedChat;
    }

    async getChatById(id: string): Promise<Chat> {
        return this.chatModel.findById(id).populate('user1', '_id fullName').populate('user2', '_id fullName').populate('messages.sender', '_id fullName');
    }

    async updateChat(id: string, updateChatDto: UpdateChatDto): Promise<Chat> {
        return this.chatModel.findByIdAndUpdate(id, updateChatDto, { new: true });
    }

    async deleteChat(id: string): Promise<Chat> {
        return this.chatModel.findByIdAndDelete(id);
    }

    async sendMessage(chatId: string, senderId: string, content: string): Promise<Message> {
        const chat = await this.chatModel.findById(chatId);
        const sender = await this.userModel.findById(senderId);
    
        if (!chat || !sender) {
          throw new Error("Chat or sender not found");
        }
    
        const message = new this.messageModel({ sender: senderId, content, sentAt: new Date() });
        const savedMessage = await message.save();
    
        chat.messages.push(savedMessage);
        await chat.save();

        this.eventGateway.sendMessage(savedMessage);
    
        return savedMessage.populate({ path: 'sender', select: '_id fullName' });
    }
}