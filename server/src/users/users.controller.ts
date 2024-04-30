import { Body, Post, Controller, UsePipes, ValidationPipe } from "@nestjs/common";
import { UsersService } from "./users.service";
import { CreateUserDTO } from "./dto/CreateUser.dto";


@Controller('users')
export class UsersController {
    constructor(private usersService: UsersService) {}

    @Post()
    @UsePipes(new ValidationPipe())
    createUser(@Body() createUserDto: CreateUserDTO) {
        return this.usersService.createUser(createUserDto);
    }
}