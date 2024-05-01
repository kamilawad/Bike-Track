import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { User } from "src/schemas/user.schema";
import { SignUpDto } from "./dto/signup.dto";

@Injectable()
export class AuthService {
    constructor(
        @InjectModel(User.name)
        private userModel: Model<User>
    ) {}

    async signUp(signUpDto: SignUpDto) {
        const { fullName, email, password} = signUpDto;
    }
}