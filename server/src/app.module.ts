import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { UserModule } from './users/user.module';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { RoutePlanModule } from './routeplans/routeplan.module';
import { ChatModule } from './chats/chat.module';
import { GroupChatModule } from './groupchats/group-chat.module';
import { EventModule } from './events/event.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: '.env',
      isGlobal: true,
  }),
  MongooseModule.forRoot(process.env.DB_URI),
  UserModule,
  RoutePlanModule,
  AuthModule,
  ChatModule,
  GroupChatModule,
  EventModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
