variable "credentials" {
  description = "Path to the GCP Service Account json file"
  default     = "./keys/my-creds.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "gcp_project_id" {
  description = "Google CLoud Project ID"
  type        = string
}

variable "gcp_region" {
  description = "Google Cloud Region"
  type        = string
  default     = "us-central1"
}

variable "location" {
  description = "project location"
  type        = string
  default     = "US"
}
variable "bq_dataset_name" {
  description = "Name of the bigquery dataset"
  default     = "demo_dataset_terraform_wk1_dt"
}