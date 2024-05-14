import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';
import { User } from './user.schema';
import { RoutePlan, RoutePlanSchema } from './routeplan.schema';
import { GroupChat } from './groupchat.schema';

@Schema()
export class Event extends Document{
  @Prop({ required: true })
  title: string;

  @Prop({ required: true })
  description: string;

  @Prop({ required: true })
  startTime: Date;

  @Prop({ required: true })
  endTime: Date;

  @Prop()
  duration: number;

  @Prop({ required: true })
  distance: number;

  @Prop({ required: true, enum: ['public', 'private'] })
  eventType: string;

  @Prop()
  elevationProfile: number[];

  @Prop({ required: true, enum: ['upcoming', 'ongoing', 'completed'], default: 'upcoming' })
  status: string;

  @Prop({ type: User, required: true })
  organizer: User;

  //@Prop({ type: RoutePlanSchema, required: true })
  //routePlan: RoutePlan;
  @Prop({
    type: { type: String, enum: ['LineString'], required: true },
    coordinates: { type: [[Number]], required: true },
  })
  route: { type: string; coordinates: number[][]; };

  @Prop({
    type: { type: String, enum: ['Point'], required: true },
    coordinates: { type: [Number], required: true },
  })
  location: { type: string; coordinates: number[] };

  @Prop({ type: [{ type: Types.ObjectId, ref: 'User' }] })
  members: User[];

  @Prop({ type: [User] })
  invitedUsers: User[];

  @Prop({ type: Types.ObjectId, ref: 'GroupChat' })
  groupChat: GroupChat;
}

export const EventSchema = SchemaFactory.createForClass(Event);