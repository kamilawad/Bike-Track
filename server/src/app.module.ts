import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { UsersModule } from './users/users.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [ConfigModule.forRoot(),
  MongooseModule.forRoot('mongodb://localhost/biketrackdb'), UsersModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
