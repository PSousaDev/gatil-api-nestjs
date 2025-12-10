import { IsNotEmpty, IsUUID, MinLength } from 'class-validator';

export class ResetPasswordRequest {
  @IsNotEmpty()
  @IsUUID()
  token: string;

  @IsNotEmpty()
  @MinLength(8)
  newPassword: string;
}
