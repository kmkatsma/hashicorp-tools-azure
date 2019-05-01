## Running docker on client VM

- run docker with commands below (linux example). First will run interactively, so better to do 2nd so can then test.

```
sudo docker run -it -p 3002:3002 --network=host  kmkatsma/ts-nest-consul-app2:basic
sudo docker run -d -p 3002:3002  --network=host --restart=always kmkatsma/ts-nest-consul-app2:basic
```

- after docker launched, run curl command below on the consul agent, and will see 'example' service listed. The node app started and registered itself.

```
curl http://127.0.0.1:8500/v1/agent/services
```
