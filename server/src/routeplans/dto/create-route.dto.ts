import { Type } from "class-transformer";
import { IsNotEmpty, ValidateNested } from "class-validator";
import { LocationDto } from "src/locations/dto/location.dto";

export class CreateRoutePlanDto {
    @ValidateNested()
    @Type(() => LocationDto)
    @IsNotEmpty()
    startLocation: LocationDto;

    @ValidateNested()
    @Type(() => LocationDto)
    @IsNotEmpty()
    endLocation: LocationDto;

    @ValidateNested({ each: true })
    @Type(() => LocationDto)
    waypoints: LocationDto[];
}