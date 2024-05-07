import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from 'src/schemas/user.schema';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { AuthModule } from 'src/auth/auth.module';

@Module({
    imports: [
        AuthModule,
        MongooseModule.forFeature([
            {
                name:User.name,
                schema: UserSchema,
            }
        ])
    ],
    providers: [UserService],
})

export class UserModule {}