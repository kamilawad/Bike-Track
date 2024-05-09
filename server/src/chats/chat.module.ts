import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { AuthModule } from "src/auth/auth.module";
import { Chat, ChatSchema } from "src/schemas/chat.schema";
import { Message, MessageSchema } from "src/schemas/message.schema";
import { User, UserSchema } from "src/schemas/user.schema";

@Module({
    imports: [
        MongooseModule.forFeature([
          { name: Chat.name, schema: ChatSchema },
          { name: User.name, schema: UserSchema },
          { name: Message.name, schema: MessageSchema },
        ]),
        AuthModule,
    ],
})
export class ChatModule {}