import { Controller, Request, Body, Get, Post, Put, UsePipes, ValidationPipe, Param, HttpException, Patch, NotFoundException, Delete, UseGuards } from "@nestjs/common";
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

    @Patch('location')
    @UseGuards(AuthGuard('jwt'))
    @UsePipes(new ValidationPipe())
    async updateLocation(@Request() req, @Body() location: Location):Promise<User> {
        console.log(req.user.id)
        return this.userService.updateLocation(req.user.id, location);
    }
    
    @Patch(':id')
    @UsePipes(new ValidationPipe())
    //async updateUser(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    async updateUser(@Request() req, @Body() updateUserDto: UpdateUserDto) {
        const updatedUser = await this.userService.updateUser(req.user.id, updateUserDto);
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
}