import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { GroupChat } from "src/schemas/groupchat.schema";
import { User } from "src/schemas/user.schema";

@Injectable()
export class EventService {
    constructor(
        @InjectModel(Event.name) private eventModel: Model<Event>,
        @InjectModel(User.name) private userModel: Model<User>,
        @InjectModel(GroupChat.name) private groupChatModel: Model<GroupChat>
    ) {}
}