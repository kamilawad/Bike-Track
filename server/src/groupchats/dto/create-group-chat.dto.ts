import { IsNotEmpty, IsString, IsArray, IsMongoId, ArrayMinSize } from 'class-validator';

export class CreateGroupChatDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsArray()
  @IsMongoId({ each: true })
  @ArrayMinSize(1)
  memberIds: string[];
}