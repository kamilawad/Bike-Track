import { Prop, Schema } from "@nestjs/mongoose";
import mongoose from "mongoose";
import { User } from "./user.schema";

@Schema()
export class Message extends Document {
    @Prop({ type: mongoose.Schema.Types.ObjectId, ref: "User" })
    sender: User;
  
    @Prop({ required: true })
    content: string;
  
    @Prop({ required: true })
    sentAt: Date;
}