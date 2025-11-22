import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  Post,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';
import { AuthUser } from './auth-user';
import { AuthService } from './auth.service';
import { CurrentUser } from './decorators/current-user.decorator';
import {
  ChangePasswordRequest,
  CheckEmailRequest,
  CheckEmailResponse,
  LoginRequest,
  LoginResponse,
  ResetPasswordRequest,
  SignupRequest,
  UserResponse,
} from './models';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('signup')
  @HttpCode(HttpStatus.CREATED)
  @ApiOperation({ summary: 'Registrar novo usuário' })
  async signup(@Body() signupRequest: SignupRequest): Promise<void> {
    await this.authService.signup(signupRequest);
  }

  @Post('login')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Fazer login' })
  async login(@Body() loginRequest: LoginRequest): Promise<LoginResponse> {
    return this.authService.login(loginRequest);
  }

  @Get('profile')
  @HttpCode(HttpStatus.OK)
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Obter perfil do usuário autenticado' })
  async getProfile(@CurrentUser() user: AuthUser): Promise<UserResponse> {
    return this.authService.getUserProfile(user.id);
  }

  @Post('check-email')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Verificar disponibilidade de email' })
  async checkEmailAvailability(
    @Body() checkEmailRequest: CheckEmailRequest,
  ): Promise<CheckEmailResponse> {
    return this.authService.isEmailAvailable(checkEmailRequest.email);
  }

  @Post('change-password')
  @HttpCode(HttpStatus.OK)
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Alterar senha do usuário autenticado' })
  async changePassword(
    @Body() changePasswordRequest: ChangePasswordRequest,
    @CurrentUser() user: AuthUser,
  ): Promise<void> {
    await this.authService.changePassword(changePasswordRequest, user.id);
  }

  @Post('forgot-password/:email')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Solicitar reset de senha' })
  async sendResetPassword(@Param('email') email: string): Promise<void> {
    await this.authService.sendResetPasswordMail(email);
  }

  @Post('reset-password')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Redefinir senha com token' })
  async resetPassword(
    @Body() resetPasswordRequest: ResetPasswordRequest,
  ): Promise<void> {
    await this.authService.resetPassword(resetPasswordRequest);
  }
}
