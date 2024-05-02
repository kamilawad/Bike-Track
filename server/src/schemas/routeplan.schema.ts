import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';
import { Location, LocationSchema } from './location.schema';

export type RoutePlanDocument = RoutePlan & Document;

@Schema()
export class RoutePlan {
    @Prop({ type: LocationSchema, required: true })
    startLocation: Location;

    @Prop({ type: LocationSchema, required: true })
    endLocation: Location;

    @Prop({ type: [LocationSchema] })
    waypoints: Location[];
}

export const RoutePlanSchema = SchemaFactory.createForClass(RoutePlan);