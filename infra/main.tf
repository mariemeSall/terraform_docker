terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "build" {
  name = "terraform_image"
  build {
    context = "/home/cytech/devops/terraform_docker"
  }
}

resource "docker_container" "container" {
  image = docker_image.build.image_id
  name  = "terraform_container"
  ports {
    internal = 80
    external = 8080
  }
}
