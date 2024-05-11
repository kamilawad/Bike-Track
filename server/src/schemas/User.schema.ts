import { Schema, Prop, SchemaFactory } from "@nestjs/mongoose";
import { LocationDetails, LocationSchema } from "./location.schema";
import { RoutePlan, RoutePlanDocument, RoutePlanSchema } from "./routeplan.schema";
import mongoose, { Document } from "mongoose";
import { Chat } from "./chat.schema";
import { GroupChat } from "./groupchat.schema";

export enum UserRole {
    USER = 'user',
    ORGANIZER = 'organizer',
    ADMIN = 'admin'
}

@Schema({ timestamps: true })
export class User extends Document{
    @Prop({ required: true })
    fullName: string;

    @Prop({ unique: true, required: true })
    email: string;

    @Prop({ required: true })
    password: string;

    @Prop({ required: true, enum: UserRole, default: 'user' })
    role: UserRole;

    @Prop({ type: LocationSchema })
    locationDetails: LocationDetails;

    @Prop({ type: [RoutePlanSchema], default: [] })
    savedRoutes: RoutePlanDocument[];

    @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }], default: [] })
    followers: User[];

    @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }], default: [] })
    following: User[];

    @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: "Chat" }] })
    individualChats: Chat[];

    @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: "GroupChat" }] })
    groupChats: GroupChat[];
}

export const UserSchema = SchemaFactory.createForClass(User);