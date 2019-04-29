# Running Consul Locally

- install consul (download and extract exe, add to path)
- create configuration file

```
{
  "bind_addr": "XXX.XX.XX.XXX",  // 0.0.0.0 or whatever your switch is
  "datacenter": "dc1",
  "data_dir": "./consul",
  "log_level": "INFO",
  "encrypt": "37NMU0F6/lNLFg7Le61blg==",
  "enable_syslog": false,
  "enable_debug": true,
  "node_name": "Server1",
  "server": true,
  "leave_on_terminate": false,
  "skip_leave_on_interrupt": true,
  "rejoin_after_leave": false
}
```

- run following where config file is

```
consul agent -dev
```

- if find this error 'Multiple Private IPv4 addresses found', use 'ipconfig' from command line to find one to bind to
- update config to use Default Switch IP in the bind_addr variable
