import { IsString, IsDateString, IsNumber, IsEnum } from 'class-validator';

export class CreateEventDto {
  @IsString()
  title: string;

  @IsString()
  description: string;

  @IsDateString()
  startTime: Date;

  @IsDateString()
  endTime: Date;

  @IsNumber()
  distance: number;

  @IsEnum(['public', 'private'])
  eventType: string;

  @IsNumber({}, { each: true })
  elevationProfile?: number[];
}