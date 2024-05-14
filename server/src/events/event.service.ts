import { BadRequestException, Injectable, NotFoundException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { GroupChat } from "src/schemas/groupchat.schema";
import { User } from "src/schemas/user.schema";
import { Event } from "src/schemas/event.schema";
import { GroupChatService } from "src/groupchats/group-chat.service";

@Injectable()
export class EventService {
    constructor(
        @InjectModel(Event.name) private eventModel: Model<Event>,
        @InjectModel(User.name) private userModel: Model<User>,
        @InjectModel(GroupChat.name) private groupChatModel: Model<GroupChat>,
        private groupChatService: GroupChatService,
    ) {}

    async joinEvent(eventId: string, userId: string): Promise<Event> {
        const event = await this.eventModel.findById(eventId);
        const user = await this.userModel.findById(userId);
      
        if (!event || !user) {
          throw new NotFoundException('Event or user not found');
        }
      
        if (event.members.some((participant) => participant._id.toString() === user._id.toString())) {
          throw new BadRequestException('User is already a participant of this event');
        }
      
        event.members.push(user);
        const savedEvent = await event.save();
      
        await this.groupChatService.joinGroupChat(savedEvent.groupChat._id, userId);
      
        return savedEvent;
    }
}