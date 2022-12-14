provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = ">= 4.0.1, < 5.0.0"

  project_id   = var.project_id
  network_name = var.network

  subnets = [
    {
      subnet_name           = var.subnetwork
      subnet_ip             = "10.10.0.0/17"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
  ]
}

# based on https://cloud.google.com/dataproc-serverless/docs/concepts/network
resource "google_compute_firewall" "dataproc-serverless-internal" {
  name          = "dataproc-serverless-internal-communication"
  network       = module.network.network_name
  direction     = "INGRESS"
  source_ranges = module.network.subnets_ips

  allow {
    protocol = "all"
  }
}
