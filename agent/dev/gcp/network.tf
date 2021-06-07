resource "google_compute_network" "scalr_agent" {
  name                    = "${local.owner}-agent-network-${local.id}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "scalr_agent" {
  name                     = "${local.owner}-agent-subnetwork-${local.id}"
  ip_cidr_range            = "10.127.0.0/20"
  network                  = google_compute_network.scalr_agent.self_link
  region                   = var.gcp_region
  private_ip_google_access = true
}

resource "google_compute_address" "static" {
  name   = "${local.owner}-agent-ipv4-address-${count.index}-${local.id}"
  count  = var.agents_count
  region = var.gcp_region
}

resource "google_compute_firewall" "fw" {
  name    = "${local.owner}-agent-network-fw-${local.id}"
  network = google_compute_network.scalr_agent.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
