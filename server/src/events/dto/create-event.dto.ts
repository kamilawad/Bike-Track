import { IsNotEmpty, IsString, IsDateString, IsOptional, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { LocationDetails } from 'src/schemas/location.schema';

export class CreateEventDto {
  @IsNotEmpty()
  @IsString()
  title: string;

  @IsNotEmpty()
  @IsString()
  description: string;

  @IsNotEmpty()
  @IsDateString()
  startTime: Date;

  @IsOptional()
  @IsDateString()
  endTime: Date;

  @IsOptional()
  duration: number;

  @IsNotEmpty()
  distance: number;

  @IsNotEmpty()
  @ValidateNested()
  @Type(() => LocationDetails)
  startLocation: LocationDetails;

  @IsOptional()
  @ValidateNested()
  @Type(() => LocationDetails)
  endLocation: LocationDetails;
}