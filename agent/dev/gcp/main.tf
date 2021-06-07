terraform {
  required_version = ">=0.15.4"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>3.70.0"

    }
  }

}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

resource "random_id" "id" {
  byte_length = 8
}

locals {
  owner = replace(var.owner, ".", "-")
  id = resource.random_id.id.hex
}


data "google_compute_image" "centos_7" {
  family  = "centos-7"
  project = "centos-cloud"
}

data "google_storage_object_signed_url" "package" {
  bucket       = var.gcp_bucket
  path         = replace(replace(data.local_file.url.content, "gs://${var.gcp_bucket}/", ""), "\n", "")
  http_method  = "GET"
  duration     = "1h"
}


resource "google_compute_instance" "agent" {
  count        = var.agents_count
  name         = "${local.owner}-scalr-agent-${count.index}-${local.id}"
  machine_type = var.gcp_machine_type
  zone         = var.gcp_zone
  network_interface {
    network    = resource.google_compute_network.scalr_agent.name
    subnetwork = resource.google_compute_subnetwork.scalr_agent.name
    access_config {
      nat_ip = google_compute_address.static[count.index].address
    }
  }
  labels = {
    owner = replace(local.owner, "-", "_")
  }
  metadata_startup_script = templatefile("install_scalr_agent_dev.bash.tpl", {
    scalr_token      = var.scalr_token
    scalr_url        = var.scalr_url
    scalr_agent_name = var.scalr_agent_name
    package_url      = data.google_storage_object_signed_url.package.signed_url
  })

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}",
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.centos_7.self_link
    }
  }
}
