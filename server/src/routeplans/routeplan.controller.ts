import { Controller } from "@nestjs/common";
import { RoutePlanService } from "./routeplan.service";


@Controller('users')
export class RoutePlanController {
    constructor(private readonly routePlanService: RoutePlanService) {}
}