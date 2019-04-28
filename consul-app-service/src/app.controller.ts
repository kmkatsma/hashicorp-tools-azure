import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('members')
  members(): any {
    const consul = require('consul')();
    consul.agent.service.list(function(err, result) {
      if (err) {
        return 'fail';
      } else {
        return result;
      }
    });
  }
}
