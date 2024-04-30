import { Body, Post, Controller, UsePipes, ValidationPipe, Get, Param, HttpException, Patch, NotFoundException } from "@nestjs/common";
import { UsersService } from "./users.service";
import { CreateUserDTO } from "./dto/CreateUser.dto";
import mongoose from "mongoose";
import { UpdateUserDto } from "./dto/UpdateUser.dto";


@Controller('users')
export class UsersController {
    constructor(private usersService: UsersService) {}

    @Post()
    @UsePipes(new ValidationPipe())
    createUser(@Body() createUserDto: CreateUserDTO) {
        return this.usersService.createUser(createUserDto);
    }

    @Get()
    getUsers() {
        return this.usersService.getUsers();
    }

    @Get(':id')
    async getUserById(@Param('id') id: string) {
        const isValid = mongoose.Types.ObjectId.isValid(id);
        if (!isValid) throw new HttpException('User not found', 404);
        const findUser = await this.usersService.getUserById(id);
        if (!findUser) throw new HttpException('User not found', 404);
        return findUser;
    }

    @Patch(':id')
    @UsePipes(new ValidationPipe())
    async updateUser(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
        const updatedUser = await this.usersService.updateUser(id, updateUserDto);
        if (!updatedUser) {
            throw new NotFoundException('User not found');
        }
        return updatedUser;
    }
}