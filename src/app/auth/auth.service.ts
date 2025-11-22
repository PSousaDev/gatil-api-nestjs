import { PrismaService } from '@core/db/prisma.service';
import {
  ConflictException,
  Injectable,
  Logger,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Prisma } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import { AuthUser } from './auth-user';
import { JwtPayload } from './jwt-payload';
import {
  ChangePasswordRequest,
  CheckEmailResponse,
  LoginRequest,
  LoginResponse,
  ResetPasswordRequest,
  SignupRequest,
  UserResponse
} from './models';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}

  /**
   * Register a new user
   */
  async signup(signupRequest: SignupRequest): Promise<void> {
    try {
      const hashedPassword = await bcrypt.hash(signupRequest.password, 10);

      await this.prisma.user.create({
        data: {
          email: signupRequest.email.toLowerCase(),
          passwordHash: hashedPassword,
          firstName: signupRequest.firstName,
          lastName: signupRequest.lastName,
          bio: signupRequest.bio || null,
          isActive: true,
        },
        select: null,
      });
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          // Unique constraint violation
          throw new ConflictException('Email já está registrado');
        }
        throw e;
      }
      throw e;
    }
  }

  /**
   * Authenticate user with email and password
   */
  async login(loginRequest: LoginRequest): Promise<LoginResponse> {
    const normalizedEmail = loginRequest.email.toLowerCase();

    const user = await this.prisma.user.findUnique({
      where: { email: normalizedEmail },
      select: {
        id: true,
        passwordHash: true,
        email: true,
        firstName: true,
        lastName: true,
        isActive: true,
      },
    });

    if (!user || !bcrypt.compareSync(loginRequest.password, user.passwordHash)) {
      throw new UnauthorizedException('Email ou senha inválidos');
    }

    if (!user.isActive) {
      throw new UnauthorizedException('Usuário inativo');
    }

    const payload: JwtPayload = {
      id: user.id,
      email: user.email,
    };

    const token = this.jwtService.signAsync(payload);

    return new LoginResponse(await token, user);
  }

  /**
   * Validate JWT payload and return user
   */
  async validateUser(payload: JwtPayload): Promise<AuthUser> {
    const user = await this.prisma.user.findUnique({
      where: { id: payload.id },
    });

    if (!user || user.email !== payload.email) {
      throw new UnauthorizedException('Usuário não encontrado');
    }

    return user;
  }

  /**
   * Change password for authenticated user
   */
  async changePassword(
    changePasswordRequest: ChangePasswordRequest,
    userId: string,
  ): Promise<void> {
    const hashedPassword = await bcrypt.hash(
      changePasswordRequest.newPassword,
      10,
    );

    await this.prisma.user.update({
      where: { id: userId },
      data: {
        passwordHash: hashedPassword,
      },
      select: null,
    });
  }

  /**
   * Request password reset (generates token)
   */
  async sendResetPasswordMail(email: string): Promise<void> {
    const user = await this.prisma.user.findUnique({
      where: { email: email.toLowerCase() },
      select: {
        id: true,
        firstName: true,
        email: true,
      },
    });

    if (!user) {
      throw new NotFoundException('Usuário não encontrado');
    }

    // Generate a unique token for password reset
    const token = this.generateToken();

    // Save the reset token (you should create a passwordReset table in your schema)
    // For now, we'll just return the token - you can implement email sending later
    this.logger.log(`Password reset token generated for user ${user.email}`);

    // TODO: Send email with password reset link
    // await this.mailSenderService.sendResetPasswordMail(
    //   user.firstName,
    //   user.email,
    //   token,
    // );
  }

  /**
   * Reset password using token
   */
  async resetPassword(resetPasswordRequest: ResetPasswordRequest): Promise<void> {
    // TODO: Implement password reset with token verification
    // For now, this is a placeholder
    const hashedPassword = await bcrypt.hash(
      resetPasswordRequest.newPassword,
      10,
    );

    // You need to verify the token first before updating the password
    this.logger.log('Password reset request received');
  }

  /**
   * Check if email is available
   */
  async isEmailAvailable(email: string): Promise<CheckEmailResponse> {
    const user = await this.prisma.user.findUnique({
      where: { email: email.toLowerCase() },
      select: { email: true },
    });

    return new CheckEmailResponse(user === null);
  }

  /**
   * Get user profile by ID
   */
  async getUserProfile(userId: string): Promise<UserResponse> {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      throw new NotFoundException('Usuário não encontrado');
    }

    return UserResponse.fromUserEntity(user);
  }

  /**
   * Generate a random token for password reset or email verification
   */
  private generateToken(): string {
    return Math.random().toString(36).substring(2, 15) +
      Math.random().toString(36).substring(2, 15);
  }
}
