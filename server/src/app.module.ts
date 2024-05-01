import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { UsersModule } from './users/user.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: '.env',
      isGlobal: true,
  }),
  MongooseModule.forRoot(process.env.DB_URI),
  UsersModule
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
