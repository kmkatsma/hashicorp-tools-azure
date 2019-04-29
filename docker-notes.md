# building docker image from consul-app-service2

- install docker, if not installed
- change directory to consul-app-service2
- run following command

```docker build . -t ts-net-consul-app2

```

- there is a WARN msg regarding kleur@3 dependency, but this can be ignored
- process will run through 8/8 steps
- to test, make sure consul is running locally
- after consul running, run via following command:

```docker run -i -t -p 3002:3002 ts-nest-consul-app2

```

- open browser and type localhost:3002/services and will list 'example' as service
