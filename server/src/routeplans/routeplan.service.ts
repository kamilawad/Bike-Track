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

    async createRoutePlan(id: string, createRoutePlanDto: CreateRoutePlanDto) : Promise<RoutePlan> {
        const newRoutePlan = new this.routePlanModel(createRoutePlanDto);
        const user = await this.userModel.findById(id);
        if (!user) {
            throw new NotFoundException('User not found');
        }
        user.savedRoutes.push(newRoutePlan);
        await user.save();
        return await newRoutePlan.save();
    }
}