import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from 'src/schemas/user.schema';
import { UsersService } from './user.service';
import { UsersController } from './user.controller';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name:User.name,
                schema: UserSchema,
            }
        ])
    ],
    providers: [UsersService],
    controllers: [UsersController]
})
export class UsersModule {}