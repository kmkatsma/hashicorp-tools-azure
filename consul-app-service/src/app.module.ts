import { Module } from '@nestjs/common';
import {
  NEST_BOOT,
  NEST_CONSUL_LOADBALANCE,
  NEST_CONSUL_CONFIG,
} from '@nestcloud/common';
import { BootModule } from '@nestcloud/boot';
import { ConsulModule } from '@nestcloud/consul';
import { ConsulConfigModule } from '@nestcloud/consul-config';
import { ConsulServiceModule } from '@nestcloud/consul-service';
import { LoadbalanceModule } from '@nestcloud/consul-loadbalance';
import { FeignModule } from '@nestcloud/feign';
import { LoggerModule } from '@nestcloud/logger';
import { TerminusModule } from '@nestjs/terminus';

@Module({
  imports: [
    LoggerModule.register(),
    BootModule.register(__dirname, `config.yaml`),
    ConsulModule.register({ dependencies: [NEST_BOOT] }),
    ConsulConfigModule.register({ dependencies: [NEST_BOOT] }),
    ConsulServiceModule.register({ dependencies: [NEST_BOOT] }),
    LoadbalanceModule.register({ dependencies: [NEST_BOOT] }),
    FeignModule.register({
      dependencies: [NEST_BOOT, NEST_CONSUL_LOADBALANCE],
    }),
    TerminusModule.forRootAsync({
      useFactory: () => ({
        endpoints: [{ url: '/health', healthIndicators: [] }],
      }),
    }),
  ],
})
export class AppModule {}
