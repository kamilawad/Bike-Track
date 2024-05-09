import { IsNotEmpty } from "class-validator";

export class CreateChatDto {
  @IsNotEmpty()
  id1: string;

  @IsNotEmpty()
  id2: string;
}