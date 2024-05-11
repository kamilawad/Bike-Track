import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { UserModule } from './users/user.module';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { RoutePlanModule } from './routeplans/routeplan.module';
import { EventsModule } from './gateway/Events.module';
import { ChatModule } from './chats/chat.module';
import { GroupChatModule } from './groupchats/group-chat.module';

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
  EventsModule,
  ChatModule,
  GroupChatModule
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
