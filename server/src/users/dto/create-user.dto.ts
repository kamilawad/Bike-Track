import { IsEmail, IsEnum, IsNotEmpty, IsString, Length, MinLength } from "class-validator";
import { UserRole } from "src/schemas/user.schema";

export class CreateUserDto {
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

    @IsEnum(UserRole)
    role: UserRole;
}