import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!';
  }

  async getServices(): Promise<any> {
    let value: any;
    const consul = require('consul')();

    return new Promise(function(resolve, reject) {
      consul.agent.service.list(function(err, result) {
        if (err) {
          reject(err);
        }

        resolve(result);
        value = result;
        return value;
      });
    });
  }
}
