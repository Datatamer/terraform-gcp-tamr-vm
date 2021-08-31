locals {
  gcp_project    = "tamr-deployment"
  default_region = "us-east1"
  default_zone   = "us-east1-b"
}

module "sample" {
  source = "../../"
  # bigtable config
  tamr_bigtable_project_id  = local.gcp_project
  tamr_bigtable_instance_id = "tamr-bigtable-instance"
  tamr_bigtable_cluster_id  = "TAMR_BIGTABLE_CLUSTER_ID"
  tamr_bigtable_min_nodes   = 1
  tamr_bigtable_max_nodes   = 10
  # dataproc
  tamr_dataproc_project_id = local.gcp_project
  tamr_dataproc_bucket     = "tamr_dataproc_home"
  tamr_dataproc_region     = local.default_region
  # dataproc_cluster_config
  tamr_dataproc_cluster_subnetwork_uri  = "projects/${local.gcp_project}/regions/${local.default_region}/subnetworks/default"
  tamr_dataproc_cluster_service_account = "tamr-instance@${local.gcp_project}.iam.gserviceaccount.com"
  tamr_dataproc_cluster_zone            = local.default_zone
  # cloud sql
  tamr_cloud_sql_project  = local.gcp_project
  tamr_cloud_sql_location = local.default_region
  tamr_cloud_sql_name     = "tamr-db"
  tamr_sql_user           = "tamr"
  tamr_sql_password       = "super_secure_password" # tfsec:ignore:GEN003
  # filesystem
  tamr_filesystem_bucket = "tamr_application_home"
}

output "tamr_config" {
  value = module.sample.tamr_config_file
}
