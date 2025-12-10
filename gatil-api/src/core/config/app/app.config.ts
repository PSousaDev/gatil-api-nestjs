import validateConfig from '@/utils/config/validate.config';
import { Environment, LogService } from '@core/constants/app.constant';
import { registerAs } from '@nestjs/config';
import {
  IsBoolean,
  IsEnum,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Max,
  Min,
} from 'class-validator';
import process from 'node:process';
import { AppConfig } from './app.config.type';

class EnvironmentVariablesValidator {
  @IsEnum(Environment)
  @IsOptional()
  NODE_ENV: typeof Environment;

  @IsBoolean()
  @IsOptional()
  IS_HTTPS: boolean;

  @IsString()
  @IsNotEmpty()
  APP_NAME: string;

  @IsInt()
  @Min(0)
  @Max(65535)
  @IsNotEmpty()
  APP_PORT: number;

  @IsInt()
  @Min(0)
  @Max(65535)
  @IsOptional()
  PORT: number;

  @IsBoolean()
  @IsOptional()
  APP_DEBUG: boolean;

  @IsBoolean()
  @IsOptional()
  APP_LOGGING: boolean;

  @IsString()
  @IsOptional()
  APP_LOG_LEVEL: string;

  @IsString()
  @IsEnum(LogService)
  @IsOptional()
  APP_LOG_SERVICE: string;

  @IsBoolean()
  @IsOptional()
  APP_LOCAL_FILE_UPLOAD: boolean;

  @IsString()
  @IsOptional()
  PREFIX_API_PATH: string;
}

export function getConfig(): AppConfig {
  const port = parseInt(process.env.APP_PORT, 10);

  return {
    nodeEnv: (process.env.NODE_ENV || Environment.Development) as Environment,
    isHttps: process.env.IS_HTTPS === 'true',
    name: process.env.APP_NAME,
    appPrefix: process.env.PREFIX_API_PATH,
    port,
    debug: process.env.APP_DEBUG === 'true',
    appLogging: process.env.APP_LOGGING === 'true',
    logLevel: process.env.APP_LOG_LEVEL || 'warn',
    logService: process.env.APP_LOG_SERVICE || LogService.Console,
    localFileUpload: process.env.APP_LOCAL_FILE_UPLOAD === 'true',
  };
}

export default registerAs<AppConfig>('app', () => {
  // eslint-disable-next-line no-console
  console.info(`Registering AppConfig from environment variables`);
  validateConfig(process.env, EnvironmentVariablesValidator);
  return getConfig();
});
