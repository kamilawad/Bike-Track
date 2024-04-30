import { Body, Post, Controller } from "@nestjs/common";
import { UsersService } from "./users.service";
import { CreateUserDTO } from "./dto/CreateUser.dto";


@Controller('users')
export class UsersController {
    constructor(private usersService: UsersService) {}

    @Post()
    createUser(@Body() createUserDto: CreateUserDTO) {
        console.log(createUserDto);
    }
}