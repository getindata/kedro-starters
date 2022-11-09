variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "{{ cookiecutter.gcloud_project }}" 
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "{{ cookiecutter.gcloud_region }}"
}

variable "network" {
  description = "The VPC network to run the process in"
  default     = "dataproc-serverless-network"
}

variable "subnetwork" {
  description = "The subnetwork to use"
  default     = "dataproc-serverless-subnetwork"
}
