terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "3.0.2"
        }
    }
}

provider "docker" {}

variable "container_configs" {
  type = list(object({
    name   = string
    enable = bool
  }))
  default = [
    { name = "nginx", enable = true },
    { name = "redis", enable = false },
    { name = "mongo", enable = true }
  ]
}

resource "docker_image" "conditional" {
  for_each = { for c in var.container_configs : c.name => c if c.enable }
  name     = each.key
}

resource "docker_container" "conditional" {
  for_each = docker_image.conditional
  image    = each.key
  name     = each.value.name
}
