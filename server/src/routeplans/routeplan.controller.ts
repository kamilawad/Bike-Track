import { Body, Controller, Post, UseGuards } from "@nestjs/common";
import { RoutePlanService } from "./routeplan.service";
import { AuthGuard } from "@nestjs/passport";
import { CreateRoutePlanDto } from "./dto/create-route.dto";


@Controller('users')
export class RoutePlanController {
    constructor(private readonly routePlanService: RoutePlanService) {}

    
}