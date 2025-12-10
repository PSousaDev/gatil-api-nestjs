import { Environment } from '@core/constants/app.constant';

export type AppConfig = {
  nodeEnv: `${Environment}`;
  isHttps: boolean;
  name: string;
  appPrefix: string;
  port: number;
  debug: boolean;
  appLogging: boolean;
  logLevel: string;
  logService: string;
  localFileUpload: boolean;
};
