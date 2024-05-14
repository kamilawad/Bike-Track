import { Module } from "@nestjs/common";
import { AuthModule } from "src/auth/auth.module";
import { EventController } from "./event.controller";
import { EventService } from "./event.service";
import { MongooseModule } from "@nestjs/mongoose";
import { GroupChat, GroupChatSchema } from "src/schemas/groupchat.schema";
import { User, UserSchema } from "src/schemas/user.schema";
import { Event, EventSchema } from "src/schemas/event.schema";

@Module({
    imports: [
        MongooseModule.forFeature([
            { name: GroupChat.name, schema: GroupChatSchema },
            { name: User.name, schema: UserSchema },
            { name: Event.name, schema: EventSchema }
        ]),
        AuthModule,
    ],
    controllers: [EventController],
    providers: [EventService]
})
export class EventModule {}