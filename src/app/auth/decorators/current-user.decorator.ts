import { createParamDecorator, ExecutionContext } from '@nestjs/common';

/**
 * Decorator to retrieve the current authenticated user
 * Example:
 * @Get()
 * someMethod(@CurrentUser() user: AuthUser) {
 *   // do something with the user
 * }
 */
export const CurrentUser = createParamDecorator(
  (data: unknown, ctx: ExecutionContext) => {
    const request = ctx.switchToHttp().getRequest();
    return request.user;
  },
);
