import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const consul = require('consul')();
  consul.agent.service.register('example', function(err) {
    if (err) {
      console.log('error', err);
    } else {
      console.log('registered');
    }
  });

  await app.listen(3002);
}
bootstrap();
