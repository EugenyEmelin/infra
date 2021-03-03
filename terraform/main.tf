terraform {
  required_version = "0.14.7"
}

provider "google" {
  project = var.project
  region  = var.project
}

resource "google_compute_instance" "app" {
  name         = "reddit-app-terraform"
  machine_type = "e2-micro"
  zone         = "europe-west2-b"
  tags         = ["reddit-app"]

  connection {
    type        = "ssh"
    host        = google_compute_instance.app.network_interface[0].access_config[0].nat_ip
    user        = "appuser"
    agent       = false
    private_key = var.privat_key_path
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_project_metadata_item" "appuser1" {
  key   = "appuser1"
  value = file(var.public_key_path)
}
resource "google_compute_project_metadata_item" "appuser2" {
  key   = "appuser2"
  value = file(var.public_key_path)
}
resource "google_compute_project_metadata_item" "appuser3" {
  key   = "appuser3"
  value = file(var.public_key_path)
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
