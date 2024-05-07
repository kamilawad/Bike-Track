import { Body, Controller, Delete, Get, Param, Patch, Post, Request, UseGuards } from "@nestjs/common";
import { RoutePlanService } from "./routeplan.service";
import { AuthGuard } from "@nestjs/passport";
import { CreateRoutePlanDto } from "./dto/create-route.dto";
import { UpdateRoutePlanDto } from "./dto/update-route.dto";


@Controller('routes')
export class RoutePlanController {
    constructor(private readonly routePlanService: RoutePlanService) {}

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createRoutePlan(@Request() req, @Body() createRoutePlanDto: CreateRoutePlanDto) {
        return this.routePlanService.createRoutePlan(req.user.id, createRoutePlanDto);
    }

    @Get()
    @UseGuards(AuthGuard('jwt'))
    async getSavedRoutes(@Request() req) {
        return this.routePlanService.getSavedRoutes(req.user.id);
    }

    /*@Patch(':id')
    @UseGuards(AuthGuard('jwt'))
    async updateRoutePlan(@Request() req, @Param('id') id: string, @Body() updateRoutePlanDto: UpdateRoutePlanDto) {
        return this.routePlanService.updateRoutePlan(req.user.id, id, updateRoutePlanDto);
    }*/

    @Delete(':id')
    @UseGuards(AuthGuard('jwt'))
    async deleteRoutePlan(@Request() req, @Param('id') id: string) {
        return this.routePlanService.deleteRoutePlan(req.user.id, id);
    }
}