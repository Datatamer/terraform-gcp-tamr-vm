data "google_compute_subnetwork" "project_subnet" {
  name    = var.subnet_name
  region  = var.region_id
  project = "tamr-networking"
}

module "sample" {
  source = "../../"

  tamr_instance_project         = var.project_id
  tamr_instance_name            = var.instance_id
  tamr_instance_zone            = var.zone_id
  tamr_instance_image           = var.instance_image
  tamr_instance_subnet          = replace(data.google_compute_subnetwork.project_subnet.self_link, "https://www.googleapis.com/compute/v1/", "")
  tamr_zip_uri                  = var.zip_url
  tamr_instance_disk_size       = 600
  tamr_instance_service_account = var.service_account
  # filesystem
  tamr_filesystem_bucket = var.filesystem_bucket

  tamr_config_file = file("config.yaml")
}

