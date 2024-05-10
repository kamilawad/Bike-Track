import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { Chat } from "src/schemas/chat.schema";
import { Message } from "src/schemas/message.schema";
import { User } from "src/schemas/user.schema";
import { CreateChatDto } from "./dto/create-chat.dto";

@Injectable()
export class ChatService {
    constructor(
        @InjectModel(Chat.name) private chatModel: Model<Chat>,
        @InjectModel(User.name) private userModel: Model<User>,
        @InjectModel(Message.name) private messageModel: Model<Message>
    ) {}

    async createChat(createChatDto: CreateChatDto): Promise<Chat> {
        const { id1, id2 } = createChatDto;
        const user1 = await this.userModel.findById(id1);
        const user2 = await this.userModel.findById(id2);
    
        if (!user1 || !user2) {
          throw new Error("user not found");
        }
    
        const chat = new this.chatModel({ user1, user2, messages: [] });
        return chat.save();
    }
}