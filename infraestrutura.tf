variable "postgres_password" {
  description = "Senha do PostgreSQL"
  type        = string
  sensitive   = true
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_image" "postgres" {
  name = "postgres:16"
}

resource "docker_volume" "db_data" {
  name = "meu-projeto-db-data"
}

resource "docker_container" "web" {
  name  = "meu-container-web"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8081
  }

  volumes {
    host_path      = "${path.cwd}/site"
    container_path = "/usr/share/nginx/html"
    read_only      = true
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}
