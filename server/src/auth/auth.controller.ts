import { Body, Controller, Post, ValidationPipe, UsePipes } from "@nestjs/common";
import { AuthService } from "./auth.service";
import { SignUpDto } from "./dto/signup.dto";
import { LogInDto } from "./dto/login.dto";

@Controller('auth')
export class AuthController {
    constructor( private authService: AuthService) {}

    @Post('/signup')
    @UsePipes(new ValidationPipe())
    signUp(@Body() signupDto: SignUpDto): Promise<{ token: string }> {
        return this.authService.signUp(signupDto);
    }

    @Post('/login')
    @UsePipes(new ValidationPipe())
    login(@Body() loginDto: LogInDto): Promise<{ token: string }> {
        return this.authService.login(loginDto);
    }
}