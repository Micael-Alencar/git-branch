resource "docker_network" "monitoring" {
  name = "monitoring-net"
}

resource "docker_image" "cadvisor" {
  name = "gcr.io/cadvisor/cadvisor:latest"
}

resource "docker_container" "cadvisor" {
  name       = "cadvisor"
  image      = docker_image.cadvisor.image_id
  privileged = true

  ports {
    internal = 8080
    external = 8082
  }

  volumes {
    host_path      = "/"
    container_path = "/rootfs"
    read_only      = true
  }

  volumes {
    host_path      = "/var/run"
    container_path = "/var/run"
    read_only      = true
  }

  volumes {
    host_path      = "/sys"
    container_path = "/sys"
    read_only      = true
  }

  volumes {
    host_path      = "/var/lib/docker"
    container_path = "/var/lib/docker"
    read_only      = true
  }

  volumes {
    host_path      = "/dev/disk"
    container_path = "/dev/disk"
    read_only      = true
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}

resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.prometheus.image_id

  ports {
    internal = 9090
    external = 9090
  }

  volumes {
    host_path      = "${path.cwd}/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
    read_only      = true
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}

resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.grafana.image_id

  ports {
    internal = 3000
    external = 3000
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}
