variable "project_id" {
  type = string
}

variable "instance_id" {
  default = "tamr-vm-example"
  type    = string
}

variable "region_id" {
  default = "us-east1"
  type    = string
}

variable "zone_id" {
  default = "us-east1-b"
  type    = string
}

variable "service_account" {
  default = "nondefault-service-account@this-project.gserviceaccount.com"
  type    = string
}

variable "filesystem_bucket" {
  type = string
}

variable "instance_image" {
  default = "tamr-private-images/bionic-base-1644877703"
  type    = string
}

variable "zip_url" {
  default = "gs://tamr-releases/v2022.005.0/unify.zip"
  type    = string
}

variable "subnet_name" {
  type = string
}
