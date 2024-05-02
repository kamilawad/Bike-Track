import { Schema, Prop, SchemaFactory } from "@nestjs/mongoose";

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

    @Prop({ required: true, enum: ['user', 'organizer', 'admin'], default: 'user' })
role: string;
}

export const UserSchema = SchemaFactory.createForClass(User);