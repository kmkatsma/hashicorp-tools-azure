import { Injectable } from '@nestjs/common';
import * as consul from 'consul';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!';
  }

  getServices(): string {
    let consulObj = new consul();
    return 'ok';
  }
}
