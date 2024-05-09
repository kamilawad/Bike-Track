import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { User } from "src/schemas/user.schema";
import { CreateUserDto } from "./dto/create-user.dto";
import { UpdateUserDto } from "./dto/update-user.dto";
import { Location } from '../schemas/location.schema';

@Injectable()
export class UserService {
    constructor(@InjectModel(User.name) private userModel: Model<User>) {}

    async createUser(createUserDto: CreateUserDto): Promise<User> {
        const newUser = new this.userModel(createUserDto);
        return await newUser.save();
    }

    async getUsers(): Promise<User[]> {
        return await this.userModel.find().exec();
    }

    async getUserById(id: string): Promise<User> {
        const user = await this.userModel.findById(id).exec();
        if (!user) {
            throw new NotFoundException('User not found');
        }
        return user;
    }

    async updateUser(id: string, updateUserDto: UpdateUserDto): Promise<User> {
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
        return await user.save();
    }

    async deleteUser(id: string): Promise<User> {
        const deletedUser = await this.userModel.findByIdAndDelete(id);
        if (!deletedUser) {
            throw new NotFoundException('User not found');
        }
        return deletedUser;
    }

    async updateLocation(id: string, location: Location): Promise<User> {
        const user = await this.userModel.findById(id);
        if (!user) {
          throw new NotFoundException('User not found');
        }

        if (!user.location) {
            user.location = location;
        } else {
            user.location.latitude = location.latitude;
            user.location.longitude = location.longitude;
        }
        return user.save();
    }

    async followUser(id: string, idToFollow: string) : Promise<User> {
        const user = await this.userModel.findById(id);
        if (!user) {
            throw new NotFoundException('User not found');
        }
        const userToFollow = await this.userModel.findById(idToFollow);
        if (!userToFollow) {
            throw new NotFoundException('User not found');
        }

        if (!user.following.includes(userToFollow.id)) {
            user.following.push(userToFollow.id);
            userToFollow.followers.push(user.id);
        }
        await user.save();
        await userToFollow.save();
        return user;
    }

    async unfollowUser(id: string, idToFollow: string) : Promise<User> {
        const user = await this.userModel.findById(id);
        if (!user) {
            throw new NotFoundException('User not found');
        }
        const userToFollow = await this.userModel.findById(idToFollow);
        if (!userToFollow) {
            throw new NotFoundException('User not found');
        }
      
        return user;
    }
}