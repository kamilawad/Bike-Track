import { IsMongoId, IsNotEmpty } from "class-validator";

export class CreateChatDto {
  @IsNotEmpty()
  @IsMongoId()
  user2Id: string;
}