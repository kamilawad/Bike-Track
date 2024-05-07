import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { RoutePlan } from "src/schemas/routeplan.schema";
import { CreateRoutePlanDto } from "./dto/create-route.dto";
import { User } from "src/schemas/user.schema";
import { UpdateRoutePlanDto } from "./dto/update-route.dto";


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

    async getSavedRoutes(userId: string): Promise<RoutePlan[]> {
        const user = await this.userModel.findById(userId).populate('savedRoutes');
        if (!user) {
            throw new NotFoundException('User not found');
        }
        return user.savedRoutes;
    }

    async getRoutePlanById(id: string): Promise<RoutePlan> {
        const routePlan = await this.routePlanModel.findById(id);
        if (!routePlan) {
            throw new NotFoundException('Route plan not found');
        }
        return routePlan;
    }

    /*async updateRoutePlan(userId: string, id: string, updateRoutePlanDto: UpdateRoutePlanDto): Promise<RoutePlan> {
        const routePlan = await this.routePlanModel.findById(id);
        if (!routePlan) {
            throw new NotFoundException('Route plan not found');
        }
        return await routePlan.save();
    }*/

    async deleteRoutePlan(userId: string, id: string): Promise<RoutePlan> {
        const user = await this.userModel.findById(userId);
        if (!user) {
            throw new NotFoundException('User not found');
        }
        user.savedRoutes = user.savedRoutes.filter(routePlan => routePlan._id.toString() !== id);
        await user.save();
        return await this.routePlanModel.findByIdAndDelete(id);
    }
}