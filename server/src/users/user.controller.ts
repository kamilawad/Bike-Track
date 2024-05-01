import { Controller, Body, Get, Post, Put, UsePipes, ValidationPipe, Param, HttpException, Patch, NotFoundException } from "@nestjs/common";
import { UserService } from "./user.service";
import { CreateUserDto } from "./dto/create-user.dto";
import { UpdateUserDto } from "./dto/update-user.dto";
import mongoose from "mongoose";


@Controller('users')
export class UserController {
    constructor(private readonly userService: UserService) {}

    @Post()
    @UsePipes(new ValidationPipe())
    async createUser(@Body() createUserDto: CreateUserDto) {
        return await this.userService.createUser(createUserDto);
    }

    @Get()
    getUsers() {
        return this.userService.getUsers();
    }

    @Get(':id')
    async getUserById(@Param('id') id: string) {
        const isValid = mongoose.Types.ObjectId.isValid(id);
        if (!isValid) throw new HttpException('User not found', 404);
        const findUser = await this.userService.getUserById(id);
        if (!findUser) throw new HttpException('User not found', 404);
        return findUser;
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
}