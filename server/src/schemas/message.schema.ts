import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose from "mongoose";
import { User } from "./user.schema";

@Schema({ timestamps: true })
export class Message extends Document {
    @Prop({ type: mongoose.Schema.Types.ObjectId, ref: "User" })
    sender: User;
  
    @Prop({ required: true })
    content: string;
  
    @Prop({ required: true })
    sentAt: Date;
}

export const MessageSchema = SchemaFactory.createForClass(Message);