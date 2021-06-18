provider "google" {
}

# Create defaul network subnetwork
/* resource "google_compute_network" "default" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "default" {
  name                     = "terraform-subnetwork"
  ip_cidr_range            = "10.127.0.0/20"
  network                  = "${google_compute_network.default.self_link}"
  region                   = "us-central1"
  private_ip_google_access = true 
}*/
  
resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
   network_interface {
    network       = "terraform-network"
    subnetwork    = "terraform-subnetwork"
    access_config {
    }
   }
  labels = {
    owner = var.owner
  }
boot_disk {
 initialize_params {
    image = "centos-cloud/centos-7"
   }
  }
 }

data "google_client_config" "current" {}
