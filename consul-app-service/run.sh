#!/usr/bin/env bash

docker build . -t ts-nest-consul-app
docker run -i -t -p 3001:3001 ts-nest-consul-app