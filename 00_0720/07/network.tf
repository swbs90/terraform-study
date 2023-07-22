resource "google_compute_network" "vpc_network" {
  name                    = "${var.project_id}-vpc-network"
  auto_create_subnetworks = "true"
}
