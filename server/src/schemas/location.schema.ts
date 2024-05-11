import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type LocationDocument = LocationDetails & Document;

@Schema({
    timestamps: true
})
export class LocationDetails {
    @Prop({ required: true })
    latitude: number;

    @Prop({ required: true })
    longitude: number;
}

export const LocationSchema = SchemaFactory.createForClass(LocationDetails);