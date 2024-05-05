import { Injectable, UnauthorizedException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { User } from "src/schemas/user.schema";
import { SignUpDto } from "./dto/signup.dto";

import * as bcrypt from 'bcryptjs';
import { JwtService } from "@nestjs/jwt";
import { LogInDto } from "./dto/login.dto";

@Injectable()
export class AuthService {
    constructor(
        @InjectModel(User.name)
        private userModel: Model<User>,
        private jwtService: JwtService
    ) {}

    async signUp(signUpDto: SignUpDto): Promise<{ token: string, user: User }> {
        const { fullName, email, password} = signUpDto;

        const hashedPassword = await bcrypt.hash(password, 10);

        const user = await this.userModel.create({
            fullName,
            email,
            password: hashedPassword,
            location: undefined,
        });
        const userData = user.toObject();
        delete userData.password;

        const token = this.jwtService.sign({ id: user._id });

        return { token, user: userData }
    }

    async login(loginDto: LogInDto): Promise<{ token: string }> {
        const { email, password} = loginDto;
        const user = await this.userModel.findOne({ email });

        if (!user) {
            throw new UnauthorizedException('Invalid credentials');
        }

        const isPasswordMatched = await bcrypt.compare(password, user.password);
        if (!isPasswordMatched) {
            throw new UnauthorizedException('Invalid credentials');
        }
        
        const token = this.jwtService.sign({ id: user._id });

        return { token };
    }
}