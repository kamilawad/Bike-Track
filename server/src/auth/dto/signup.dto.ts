import { IsEmail, IsNotEmpty, IsString, Length, MinLength } from "class-validator";

export class SignUpDto {
    @IsString()
    @Length(4, 50)
    fullName: string;

    @IsString()
    @IsEmail()
    email: string;

    @IsNotEmpty()
    @IsString()
    @MinLength(8)
    password: string;
}