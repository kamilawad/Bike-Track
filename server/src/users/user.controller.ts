import { Controller, Body, Get, Post, Put, UsePipes, ValidationPipe, Param, HttpException, Patch, NotFoundException, Delete, UseGuards } from "@nestjs/common";
import { UserService } from "./user.service";
import { CreateUserDto } from "./dto/create-user.dto";
import { UpdateUserDto } from "./dto/update-user.dto";
import mongoose from "mongoose";
import { Location } from '../schemas/location.schema';
import { AuthGuard } from "@nestjs/passport";
import { User } from "src/schemas/user.schema";


@Controller('users')
export class UserController {
    constructor(private readonly userService: UserService) {}

    @Post()
    @UsePipes(new ValidationPipe())
    async createUser(@Body() createUserDto: CreateUserDto) {
        return await this.userService.createUser(createUserDto);
    }

    @Get()
    async getUsers() {
        return await this.userService.getUsers();
    }

    @Get(':id')
    async getUserById(@Param('id') id: string) {
        const user = await this.userService.getUserById(id);
        if (!user) throw new HttpException('User not found', 404);
        return user;
    }

    @Patch(':id')
    @UsePipes(new ValidationPipe())
    async updateUser(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
        const updatedUser = await this.userService.updateUser(id, updateUserDto);
        if (!updatedUser) {
            throw new NotFoundException('User not found');
        }
        return updatedUser;
    }

    @Delete(':id')
    async deleteUser(@Param('id') id: string) {
        const isValid = mongoose.Types.ObjectId.isValid(id);
        if (!isValid) throw new HttpException('User not found', 404);
        const deletedUser = await this.userService.deleteUser(id);
        if (!deletedUser) {
            throw new NotFoundException('User not found');
        }
        return deletedUser;
    }

    @Patch(':id/location')
    @UseGuards(AuthGuard('jwt'))
    async updateLocation(@Param('id') id: string, @Body() location: Location):Promise<User> {
        return this.userService.updateLocation(id, location);
    }
}