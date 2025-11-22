import { AuthUser } from '../../auth-user';

export class UserResponse {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  bio: string | null;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;

  constructor(user: AuthUser) {
    this.id = user.id;
    this.email = user.email;
    this.firstName = user.firstName;
    this.lastName = user.lastName;
    this.bio = user.bio;
    this.isActive = user.isActive;
    this.createdAt = user.createdAt;
    this.updatedAt = user.updatedAt;
  }

  static fromUserEntity(user: AuthUser): UserResponse {
    return new UserResponse(user);
  }
}
