import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';
import { LocationDetails, LocationSchema } from './location.schema';

export type RoutePlanDocument = RoutePlan & Document;

@Schema()
export class RoutePlan {
    @Prop({ type: LocationSchema, required: true })
    startLocation: LocationDetails;

    @Prop({ type: LocationSchema, required: true })
    endLocation: LocationDetails;

    @Prop({ type: [LocationSchema] })
    waypoints: LocationDetails[];
}

export const RoutePlanSchema = SchemaFactory.createForClass(RoutePlan);