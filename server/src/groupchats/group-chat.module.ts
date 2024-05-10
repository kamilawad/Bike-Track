import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { GroupChat, GroupChatSchema } from "src/schemas/groupchat.schema";
import { Message, MessageSchema } from "src/schemas/message.schema";
import { User, UserSchema } from "src/schemas/user.schema";

@Module({
    imports: [
        MongooseModule.forFeature([
            { name: GroupChat.name, schema: GroupChatSchema },
            { name: User.name, schema: UserSchema },
            { name: Message.name, schema: MessageSchema },
        ]),
    ],
    controllers: [],
    providers: [],
})
export class GroupChatModule {}