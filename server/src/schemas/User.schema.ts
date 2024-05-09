import { Schema, Prop, SchemaFactory } from "@nestjs/mongoose";
import { Location, LocationSchema } from "./location.schema";
import { RoutePlan, RoutePlanDocument, RoutePlanSchema } from "./routeplan.schema";
import mongoose from "mongoose";

export enum UserRole {
    USER = 'user',
    ORGANIZER = 'organizer',
    ADMIN = 'admin'
}

@Schema({
    timestamps: true
})
export class User {
    @Prop({ required: true })
    fullName: string;

    @Prop({ unique: true, required: true })
    email: string;

    @Prop({ required: true })
    password: string;

    @Prop({ required: true, enum: UserRole, default: 'user' })
    role: UserRole;

    @Prop({ type: LocationSchema })
    location: Location;

    @Prop({ type: [RoutePlanSchema], default: [] })
    savedRoutes: RoutePlanDocument[];

    @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }], default: [] })
    followers: User[];

    @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }], default: [] })
    following: User[];
}

export const UserSchema = SchemaFactory.createForClass(User);