import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';
import { User } from './user.schema';
import { RoutePlan, RoutePlanSchema } from './routeplan.schema';

export type EventDocument = Event & Document;

@Schema()
export class Event {
  @Prop({ required: true })
  title: string;

  @Prop({ required: true })
  startTime: Date;

  @Prop({ required: true })
  endTime: Date;

  @Prop({ required: true })
  duration: number;

  @Prop({ required: true })
  distance: number;

  @Prop({ required: true, enum: ['upcoming', 'ongoing', 'completed'], default: 'upcoming' })
  status: string;

  @Prop({ type: User, required: true })
  organizer: User;

  @Prop({ type: RoutePlanSchema, required: true })
  routePlan: RoutePlan;

  @Prop({ type: [User] })
  members: User[];

  @Prop({ type: [User] })
  invitedUsers: User[];
}

export const EventSchema = SchemaFactory.createForClass(Event);