# Container do PostgreSQL
resource "docker_container" "db" {
  name  = "meu-container-db"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_PASSWORD=${var.postgres_password}"
  ]

  ports {
    internal = 5432
    external = 5432
  }

  volumes {
    volume_name    = docker_volume.db_data.name
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}
