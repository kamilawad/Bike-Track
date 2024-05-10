import { IsNotEmpty } from "class-validator";

export class CreateChatDto {
  @IsNotEmpty()
  user1Id: string;

  @IsNotEmpty()
  user2Id: string;
}