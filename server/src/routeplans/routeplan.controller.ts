import { Body, Controller, Delete, Param, Post, Request, UseGuards } from "@nestjs/common";
import { RoutePlanService } from "./routeplan.service";
import { AuthGuard } from "@nestjs/passport";
import { CreateRoutePlanDto } from "./dto/create-route.dto";


@Controller('routes')
export class RoutePlanController {
    constructor(private readonly routePlanService: RoutePlanService) {}

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createRoutePlan(@Request() req, @Body() createRoutePlanDto: CreateRoutePlanDto) {
        return this.routePlanService.createRoutePlan(req.user.id, createRoutePlanDto);
    }
}