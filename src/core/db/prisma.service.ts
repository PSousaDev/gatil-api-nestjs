import { Injectable, Logger, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';


@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  private readonly logger = new Logger(PrismaService.name);


  async onModuleInit() {
    try {
      await this.$connect();
      this.logger.log('✅ Banco de dados conectado com sucesso');
    } catch (error) {
      this.logger.error('❌ Erro ao conectar ao banco de dados:', error);
      throw error;
    }
  }

  async onModuleDestroy() {
    try {
      await this.$disconnect();
      this.logger.log('✅ Banco de dados desconectado');
    } catch (error) {
      this.logger.error('❌ Erro ao desconectar do banco de dados:', error);
    }
  }
}
