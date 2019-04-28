import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { NestLogger } from '@nestcloud/logger';
import { NestCloud } from '@nestcloud/core';

async function bootstrap() {
  const app = NestCloud.create(
    await NestFactory.create(AppModule, {
      logger: new NestLogger({
        path: __dirname,
        filename: `config.yaml`,
      }),
    }),
  );

  await app.listen(3001);
}

bootstrap();
