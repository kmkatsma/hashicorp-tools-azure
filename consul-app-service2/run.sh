#!/usr/bin/env bash

docker build . -t ts-nest-consul-app2
docker run -i -t -p 3002:3002 ts-nest-consul-app2