import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { User } from "src/schemas/User.schema";
import { CreateUserDTO } from "./dto/CreateUser.dto";
import { UpdateUserDto } from "./dto/UpdateUser.dto";

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

    async updateUser(id: string, updateUserDto: UpdateUserDto) {
        const user = await this.userModel.findById(id);
        if (!user) {
            throw new NotFoundException('User not found');
        }
        if (updateUserDto.fullName) {
            user.fullName = updateUserDto.fullName;
        }
        if (updateUserDto.password) {
            user.password = updateUserDto.password;
        }
        return user.save();
        //return this.userModel.findByIdAndUpdate(id, updateUserDto, { new: true });
    }
}