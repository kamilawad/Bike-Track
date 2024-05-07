import { Type } from "class-transformer";
import { ValidateNested } from "class-validator";
import { LocationDto } from "src/locations/dto/location.dto";

export class UpdateRoutePlanDto {
    @ValidateNested()
    @Type(() => LocationDto)
    startLocation?: LocationDto;

    @ValidateNested()
    @Type(() => LocationDto)
    endLocation?: LocationDto;

    @ValidateNested({ each: true })
    @Type(() => LocationDto)
    waypoints?: LocationDto[];
}