import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { User } from "src/schemas/User.schema";
import { CreateUserDTO } from "./dto/CreateUser.dto";

@Injectable()
export class UsersService {
    constructor(@InjectModel(User.name) private userModel: Model<User>) {}

    createUser(createUserDto: CreateUserDTO) {
        const newUser = new this.userModel(createUserDto);
        return newUser.save();
    }

    getUsers() {
        return this.userModel.find();
    }

    getUserById(id: string) {
        return this.userModel.findById(id);
    }
}