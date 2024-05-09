import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { User } from "./user.schema";

@Schema()
export class GroupChat extends Document{
    @Prop({ required: true })
    name: string;

    @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: "User" }] })
    members: User[];
}

export const GroupChatSchema = SchemaFactory.createForClass(GroupChat);