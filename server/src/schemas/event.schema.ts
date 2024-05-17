import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';
import { User } from './user.schema';
import { GroupChat } from './groupchat.schema';
import { LocationDetails } from './location.schema';

@Schema()
export class Event extends Document {
  @Prop({ required: true })
  title: string;

  @Prop({ required: true })
  description: string;

  @Prop({ required: true })
  startTime: Date;

  @Prop()
  endTime: Date;

  @Prop()
  duration: number;

  @Prop({ required: true })
  distance: number;

  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  organizer: User;

  @Prop()
  startLocation: LocationDetails;

  @Prop()
  endLocation: LocationDetails;

  @Prop({ type: [{ type: Types.ObjectId, ref: 'User' }] })
  members: User[];

  @Prop({ type: Types.ObjectId, ref: 'GroupChat' })
  groupChat: GroupChat;
}

export const EventSchema = SchemaFactory.createForClass(Event);