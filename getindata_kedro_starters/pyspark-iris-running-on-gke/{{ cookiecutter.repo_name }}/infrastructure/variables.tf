variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "{{ cookiecutter.gcloud_project }}" 
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "{{ cookiecutter.gcloud_region }}"
}

variable "zones" {
  type        = list(string)
  description = "The zone to host the cluster in (required if is a zonal cluster)"
  default     = ["{{ cookiecutter.gcloud_zone }}"]
}

variable "cluster_name" {
  default = "kedro-running-spark-on-k8s"
}

variable "network" {
  description = "The VPC network to host the cluster in"
  default     = "kedro-spark-network"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
  default     = "kedro-spark-subnet"
}
