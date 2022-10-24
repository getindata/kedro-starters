provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zones[0]
}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = ">= 4.0.1, < 5.0.0"

  project_id   = var.project_id
  network_name = var.network

  subnets = [
    {
      subnet_name   = var.subnetwork
      subnet_ip     = "10.0.0.0/17"
      subnet_region = var.region
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    (var.subnetwork) = [
      {
        range_name    = "ip-range-pods"
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = "ip-range-services"
        ip_cidr_range = "192.168.64.0/18"
      },
    ]
  }
}



module "gke" {
  source     = "terraform-google-modules/kubernetes-engine/google"
  name       = var.cluster_name
  project_id = var.project_id
  regional   = false
  region     = var.region
  zones      = var.zones

  network                = var.network
  subnetwork             = var.subnetwork
  ip_range_pods          = module.network.subnets_secondary_ranges[0][0].range_name
  ip_range_services      = module.network.subnets_secondary_ranges[0][1].range_name
  create_service_account = true
  grant_registry_access  = true
  initial_node_count     = 1

  cluster_autoscaling = {
    autoscaling_profile = "OPTIMIZE_UTILIZATION"
  }

  node_pools = [
    {
      name         = "spark-drivers"
      machine_type = "n1-standard-1"
      min_count    = 0
      max_count    = 10
      disk_size_gb = 30
      disk_type    = "pd-standard"
    },
    {
      name         = "spark-executors"
      machine_type = "n1-standard-2"
      min_count    = 0
      max_count    = 10
      disk_size_gb = 30
      disk_type    = "pd-standard"
      spot         = true
    },
  ]
}
