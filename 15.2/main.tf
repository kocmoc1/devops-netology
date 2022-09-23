// Create SA
resource "yandex_iam_service_account" "sa" {
  folder_id = local.folder_id
  name      = "s3-sa-15-2"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Use keys to create bucket
resource "yandex_storage_bucket" "clokub-13092022" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "15-2-bucket"
}
resource "yandex_storage_object" "some-picture.jpg" {
  bucket = "clokub-13092022"
  key    = "some-picture"
  source = "images/some-picture.jpg"
  acl    = "public-read"
}

resource "yandex_iam_service_account" "sa-15-2" {
  name        = "sa-15-2"
  description = "sa-15-2"
}


resource "yandex_compute_instance_group" "lamp-group" {
  name                = "LAMP-ig"
  folder_id           = "b1gqc40o4kbdd6irif00"
  service_account_id  = "${yandex_iam_service_account.sa-15-2.id}"
  deletion_protection = true
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 4
      }
    }
    network_interface {
      network_id = "enp3rtt24j6gtando17d"
      subnet_ids = ["${yandex_vpc_subnet.public-subnet-a.id}"]
    }
    labels = {
      label1 = "label1-value"
      label2 = "label2-value"
    }
    metadata = {
      user-data = "runcmd:\n  - echo '<html><title>Some image</title><body><img src='https://storage.yandexcloud.net/clokub-13092022/some-picture.jpg' alt='loading...'/> </body></html>' > /var/www/html/index.html"
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }


  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  al__cpLocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
  health_check {
    interval  = 10
    timeout   = 5
    
    tcp_options {
        port = 80
    }
  }

}

resource "yandex_lb_network_load_balancer" "lb1" {
  name = "my-network-load-balancer"

  listener {
    name = "my-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_compute_instance_group.lamp-group.load_balancer[0].target_group_id}"

    healthcheck {
      name = "http" 
      
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }
}
