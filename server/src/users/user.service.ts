import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { User } from "src/schemas/user.schema";
import { CreateUserDto } from "./dto/create-user.dto";
import { UpdateUserDto } from "./dto/update-user.dto";

@Injectable()
export class UserService {
    constructor(@InjectModel(User.name) private userModel: Model<User>) {}

    async createUser(createUserDto: CreateUserDto) : Promise<User> {
        const newUser = new this.userModel(createUserDto);
        return await newUser.save();
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
        /*const { fullName, password } = updateUserDto;
        return await this.userModel.findByIdAndUpdate(id, { fullName, password}, { new: true, runValidators: true, });
        //return this.userModel.findByIdAndUpdate(id, updateUserDto, { new: true });*/
    }
}