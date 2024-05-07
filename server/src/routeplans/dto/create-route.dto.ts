import { IsNotEmpty } from "class-validator";


class LocationDto {
    @IsNotEmpty()
    latitude: number;

    @IsNotEmpty()
    longitude: number;
}