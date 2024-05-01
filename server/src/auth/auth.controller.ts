import { Controller } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { User } from "src/schemas/user.schema";


@Controller('auth')
export class AuthController {
    constructor(@InjectModel(User.name) private userModel: Model<User>) {}
}