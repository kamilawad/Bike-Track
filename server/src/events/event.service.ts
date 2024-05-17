import { BadRequestException, ForbiddenException, Injectable, NotFoundException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { GroupChat } from "src/schemas/groupchat.schema";
import { User } from "src/schemas/user.schema";
import { Event } from "src/schemas/event.schema";
import { GroupChatService } from "src/groupchats/group-chat.service";
import { CreateEventDto } from "./dto/create-event.dto";

@Injectable()
export class EventService {
    constructor(
        @InjectModel(Event.name) private eventModel: Model<Event>,
        @InjectModel(User.name) private userModel: Model<User>,
        @InjectModel(GroupChat.name) private groupChatModel: Model<GroupChat>,
        private groupChatService: GroupChatService,
    ) {}

    async createEvent(createEventDto: CreateEventDto, organizerId: string): Promise<Event> {
      const { title, description, startTime, endTime, duration, distance, startLocation, endLocation } = createEventDto;
  
      const organizer = await this.userModel.findById(organizerId);
      if (!organizer) {
        throw new NotFoundException('Organizer not found');
      }
  
      const groupChat = new this.groupChatModel({
        name: title,
        members: [organizer],
        admins: [organizer],
        messages: [],
      });
      const savedGroupChat = await groupChat.save();
  
      const event = new this.eventModel({
        title,
        description,
        startTime,
        endTime,
        duration,
        distance,
        organizer,
        startLocation,
        endLocation,
        members: [organizer],
        groupChat: savedGroupChat,
      });
  
      return event.save();
    }

    async addMember(eventId: string, memberId: string): Promise<Event> {
      console.log(eventId);
      console.log(memberId);
      const event = await this.eventModel.findById(eventId);
      const member = await this.userModel.findById(memberId);
      const groupChat = await this.groupChatModel.findById(event.groupChat);
  
      if (!event || !member || !groupChat) {
        throw new NotFoundException('Event, member, or group chat not found');
      }
  
      if (event.members.some((m) => m._id.toString() === member._id.toString())) {
        throw new Error('Member already part of the event');
      }
  
      event.members.push(member);
      groupChat.members.push(member);
  
      await event.save();
      await groupChat.save();
  
      return event;
    }

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

    async findAll(): Promise<Event[]> {
        return this.eventModel.find().populate('organizer', 'fullName').populate('participants', 'fullName');
    }

    async findById(id: string): Promise<Event> {
        const event = await this.eventModel.findById(id).populate('organizer', 'fullName').populate('participants', 'fullName');
        if (!event) {
          throw new NotFoundException(`Event with ID ${id} not found`);
        }
        return event;
    }
}