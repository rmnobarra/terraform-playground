terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "3.0.2"
        }
    }
}

provider "docker" {}

variable "containers" {
    type = list(string)
    default = ["nginx", "redis", "mongo"]
}

variable "ports" {
    type = map(number)
    default = {
        nginx = 80
        redis = 6379
        mongo = 27017
    }
}

resource "docker_image" "example" {
    for_each = toset(var.containers)
    name     = each.value
}

resource "docker_container" "example" {
    for_each = docker_image.example
    image    = each.key
    name     = each.value.name

    ports {
        internal = var.ports[each.key]
        external = var.ports[each.key]
    }
}