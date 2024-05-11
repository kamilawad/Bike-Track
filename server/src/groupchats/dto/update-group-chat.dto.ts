import { IsString, IsOptional, IsArray, IsMongoId } from 'class-validator';

export class UpdateGroupChatDto {
  @IsString()
  @IsOptional()
  name?: string;

  @IsArray()
  @IsMongoId({ each: true })
  @IsOptional()
  memberIds?: string[];
}