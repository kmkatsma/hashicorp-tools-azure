# Running docker container as a nomad job

- SSH into one of the nomad 'servers'
- Create example.nomad file on server using content of the 'app-service-job.nomad' file from this repo.
- Run following command-line:

```
nomad job run example.nomad
```

- This will schedule job to run on the client
- To see results of the job, ssh to the client1 VM, and then run

```
nomad status docs2
```

-you should see results that job is now running.  
-since job is running, can now test that you can call the service in the container with this command:

```
curl http://localhost:3002/health
```

- This call should return 'OK'
