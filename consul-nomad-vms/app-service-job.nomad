job "docs2" {
  datacenters = ["consul-westus"]
  type = "service"
  group "webs2" {

    count = 1

    task "frontend2" {
      driver = "docker"
      kill_timeout = "600s"
      config {
        image = "kmkatsma/ts-nest-consul-app2:basic"
        network_mode = "host"
      }

      service {
        port = "http"
      }

       resources {

        network {

          port "http" { static = 3002 }

       }
      }
    }
  }
}