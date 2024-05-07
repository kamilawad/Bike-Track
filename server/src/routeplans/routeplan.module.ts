import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { AuthModule } from "src/auth/auth.module";
import { RoutePlan, RoutePlanSchema } from "src/schemas/routeplan.schema";
@Module({
    imports: [
        AuthModule,
        MongooseModule.forFeature([
            {
                name:RoutePlan.name,
                schema: RoutePlanSchema,
            }
        ])
    ],
    providers: [RoutePlanService],
    controllers: [RoutePlanController],
    exports: [RoutePlanService]
})
export class RoutePlanModule {}