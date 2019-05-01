# Terraform Output

Terraform output should return something like this below. If the private_key.pem failed to create, the output of the private key returned during terraform must be saved into private_key.pem file, and then following steps will work.

```
jumphost_westus_ssh_connection_strings = [
    ssh-add private_key.pem && ssh -A -i private_key.pem azure-user@40.83.169.18
]
```

- the information can be used from command shell to connect to jumpbox created by terraform deploy

```
ssh -A -i azure-user@40.83.169.12
```

- once connected to jumpbox, can use 'consul members' command to see consul servers.
- ssh into one of the servers with one of the server IPs

```
 ssh azure-user@10.0.80.4
```

- ssh into client1 VM with below command

```
 ssh azure-user@10.0.96.4
```

-the client machine can be used to run docker container that connects to consul.
