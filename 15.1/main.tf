terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "SOME_TOKEN"
  cloud_id  = "SOME_CLOUD"
  folder_id = "SOME_FOLDER"
  zone      = "ru-central1-a"
}


# resource "yandex_vpc_network" "default" {
# }

resource "yandex_vpc_subnet" "public-subnet-a" {
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = "enp3rtt24j6gtando17d"
}

resource "yandex_vpc_subnet" "private-subnet-a" {
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-a"
  network_id     = "enp3rtt24j6gtando17d"
}

resource "yandex_vpc_route_table" "private-rt-a" {
  network_id = "enp3rtt24j6gtando17d"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat-instance.network_interface.0.ip_address
  }
}

resource "yandex_compute_instance" "nat-instance" {
  name        = "nat-instance"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public-subnet-a.id
    ip_address = "192.168.10.254"
  }

  metadata = {
    ssh-keys = "nposk:${file("~/.ssh/id_rsa.pub")}"
  }
}



resource "yandex_compute_instance" "public-subnet-ubuntu" {
  name        = "public-subnet-ubuntu"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8oc4qnq5kg274e0vbn"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public-subnet-a.id
    nat = true
  }

  metadata = {
    ssh-keys = "nposk:${file("~/.ssh/id_rsa.pub")}"
    serial-port-enable = 1
  }
}

resource "yandex_compute_instance" "private-subnet-ubuntu" {
  name        = "private-subnet-ubuntu"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8oc4qnq5kg274e0vbn"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private-subnet-a.id
  }

  metadata = {
    ssh-keys = "nposk:${file("~/.ssh/id_rsa.pub")}"
  }
}

