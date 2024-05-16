import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema()
export class Profile extends Document {
  @Prop()
  profilePicture: string;

  @Prop()
  birthday: Date;

  @Prop()
  bio: string;
}

export const ProfileSchema = SchemaFactory.createForClass(Profile);