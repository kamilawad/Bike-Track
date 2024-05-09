import { Prop, Schema } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { User } from "./user.schema";

@Schema()
export class Chat extends Document{
    @Prop({ type: mongoose.Schema.Types.ObjectId, ref: "User", required: true, })
    sender: User;

    @Prop({ type: mongoose.Schema.Types.ObjectId, ref: "User", required: true, })
    receiver: User;
}