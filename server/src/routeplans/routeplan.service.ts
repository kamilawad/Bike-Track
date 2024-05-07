import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { RoutePlan } from "src/schemas/routeplan.schema";
import { CreateRoutePlanDto } from "./dto/create-route.dto";
import { User } from "src/schemas/user.schema";


@Injectable()
export class RoutePlanService {
    constructor(@InjectModel(RoutePlan.name) private routePlanModel: Model<RoutePlan>,
    @InjectModel(User.name) private userModel: Model<User>) {}

    
}