import { IsNotEmpty, IsOptional, IsString, Length, MinLength } from 'class-validator';

export class UpdateUserDto {
    @IsOptional()
    @IsString()
    @Length(4, 50)
    fullName: string;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    @MinLength(8)
    password: string;
}