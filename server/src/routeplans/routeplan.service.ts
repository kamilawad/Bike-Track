import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { RoutePlan } from "src/schemas/routeplan.schema";


@Injectable()
export class RoutePlanService {
    constructor(@InjectModel(RoutePlan.name) private routePlanModel: Model<RoutePlan>) {}

}