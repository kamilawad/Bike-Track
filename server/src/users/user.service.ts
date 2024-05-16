import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { User } from "src/schemas/user.schema";
import { CreateUserDto } from "./dto/create-user.dto";
import { UpdateUserDto } from "./dto/update-user.dto";
import { LocationDetails } from '../schemas/location.schema';
//import { join } from "path";
//import { promises as fs } from 'fs';

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

    async updateLocation(id: string, location: LocationDetails): Promise<User> {
        const user = await this.userModel.findById(id);
        if (!user) {
          throw new NotFoundException('User not found');
        }

        if (!user.locationDetails) {
            user.locationDetails = location;
        } else {
            user.locationDetails.latitude = location.latitude;
            user.locationDetails.longitude = location.longitude;
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

    async unfollowUser(id: string, idToUnfollow: string) : Promise<User> {
        const user = await this.userModel.findById(id);
        if (!user) {
            throw new NotFoundException('User not found');
        }
        const userToUnfollow = await this.userModel.findById(idToUnfollow);
        if (!userToUnfollow) {
            throw new NotFoundException('User not found');
        }

        user.following = user.following.filter(userId => userId.toString() !== userToUnfollow._id.toString());
        userToUnfollow.followers = userToUnfollow.followers.filter(userId => userId.toString() !== user._id.toString());
        await user.save();
        await userToUnfollow.save();
        return user;
    }

    /*async saveAvatar(file: Express.Multer.File, userId: string) {
        const user = await this.userModel.findById(userId);
        if (!user) {
            throw new NotFoundException('User not found');
        }
        
        const uploadDir = join(__dirname, '..', 'uploads', 'avatars');
        await fs.mkdir(uploadDir, { recursive: true });
        const filePath = join(uploadDir, `${userId}.${file.originalname.split('.').pop()}`);
        await fs.writeFile(filePath, file.buffer);
        return { path: filePath };
    }*/
}