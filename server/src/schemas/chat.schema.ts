import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { User } from "./user.schema";
import { Message, MessageSchema } from "./message.schema";

@Schema({ timestamps: true })
export class Chat extends Document{
    @Prop({ type: mongoose.Schema.Types.ObjectId, ref: "User", required: true, })
    user1: User;

    @Prop({ type: mongoose.Schema.Types.ObjectId, ref: "User", required: true, })
    user2: User;

    @Prop({ type: [MessageSchema] })
    messages: Message[];
}

export const ChatSchema = SchemaFactory.createForClass(Chat);