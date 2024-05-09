import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { User } from "./user.schema";
import { Message, MessageSchema } from "./message.schema";

@Schema({ timestamps: true })
export class GroupChat extends Document{
    @Prop({ required: true })
    name: string;

    @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: "User" }] })
    members: User[];

    @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: "User" }] })
    admins: User[];

    @Prop({ type: [MessageSchema] })
    messages: Message[];
}

export const GroupChatSchema = SchemaFactory.createForClass(GroupChat);