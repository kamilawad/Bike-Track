import { IsNotEmpty, IsString, IsArray, IsMongoId } from 'class-validator';

export class CreateGroupChatDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsArray()
  @IsMongoId({ each: true })
  memberIds: string[];
}