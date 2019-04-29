import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('health')
  getHealth(): string {
    return 'OK';
  }

  @Get('services')
  async getServices(): Promise<string> {
    var service = await this.appService.getServices();
    console.log('service', service);
    return service;
  }
}
