import { Schema, Prop, SchemaFactory } from "@nestjs/mongoose";
import { Location, LocationSchema } from "./location.schema";

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
}

export const UserSchema = SchemaFactory.createForClass(User);