import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { Chat } from "src/schemas/chat.schema";
import { Message } from "src/schemas/message.schema";
import { User } from "src/schemas/user.schema";

@Injectable()
export class ChatService {
    constructor(
        @InjectModel(Chat.name) private chatModel: Model<Chat>,
        @InjectModel(User.name) private userModel: Model<User>,
        @InjectModel(Message.name) private messageModel: Model<Message>
    ) {}
}