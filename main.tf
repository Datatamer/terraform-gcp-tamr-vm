locals {
  tamr_dataproc_cluster_zone            = var.tamr_dataproc_cluster_zone == "" ? var.tamr_instance_zone : var.tamr_dataproc_cluster_zone
  tamr_dataproc_cluster_subnetwork_uri  = var.tamr_dataproc_cluster_subnetwork_uri == "" ? var.tamr_instance_subnet : var.tamr_dataproc_cluster_subnetwork_uri
  tamr_dataproc_cluster_service_account = var.tamr_dataproc_cluster_service_account == "" ? var.tamr_instance_service_account : var.tamr_dataproc_cluster_service_account

  tamr_es_apihost = var.tamr_es_apihost == "" ? "${google_compute_address.tamr_ip.address}:9200" : var.tamr_es_apihost
  remote_es       = var.tamr_es_apihost == "" ? false : true

  tamr_bigtable_project_id = var.tamr_bigtable_project_id == "" ? var.tamr_instance_project : var.tamr_bigtable_project_id
  tamr_cloud_sql_project   = var.tamr_cloud_sql_project == "" ? var.tamr_instance_project : var.tamr_cloud_sql_project
  tamr_dataproc_project_id = var.tamr_dataproc_project_id == "" ? var.tamr_instance_project : var.tamr_dataproc_project_id

  dataproc_config  = var.tamr_dataproc_cluster_config == "" ? local.default_dataproc : var.tamr_dataproc_cluster_config
  tamr_config      = var.tamr_config == "" ? local.default_tamr_config : var.tamr_config
  external_ip      = var.tamr_external_ip == true ? 1 : 0
  spark_properties = var.tamr_spark_properties_override == "" ? file("${path.module}/files/spark_properties.json") : var.tamr_spark_properties_override

  default_dataproc = templatefile("${path.module}/templates/dataproc.yaml.tmpl", {
    subnetwork_uri       = local.tamr_dataproc_cluster_subnetwork_uri
    service_account      = local.tamr_dataproc_cluster_service_account
    zone                 = local.tamr_dataproc_cluster_zone
    region               = var.tamr_dataproc_region
    stackdriver_logging  = var.tamr_dataproc_cluster_enable_stackdriver_logging
    version              = var.tamr_dataproc_cluster_version
    tamr_dataproc_bucket = var.tamr_dataproc_bucket

    master_instance_type = var.tamr_dataproc_cluster_master_instance_type
    master_disk_size     = var.tamr_dataproc_cluster_master_disk_size

    worker_machine_type   = var.tamr_dataproc_cluster_worker_machine_type
    worker_num_instances  = var.tamr_dataproc_cluster_worker_num_instances
    worker_num_local_ssds = var.tamr_dataproc_cluster_worker_num_local_ssds

    worker_preemptible_machine_type   = var.tamr_dataproc_cluster_worker_preemptible_machine_type
    worker_preemptible_num_instances  = var.tamr_dataproc_cluster_worker_preemptible_num_instances
    worker_preemptible_num_local_ssds = var.tamr_dataproc_cluster_worker_preemptible_num_local_ssds
  })


  default_tamr_config = templatefile("${path.module}/templates/tamr_config.yaml.tmpl", {
    # Bigtable
    tamr_hbase_namespace      = var.tamr_hbase_namespace
    tamr_bigtable_project_id  = local.tamr_bigtable_project_id
    tamr_bigtable_instance_id = var.tamr_bigtable_instance_id
    tamr_bigtable_cluster_id  = var.tamr_bigtable_cluster_id
    tamr_bigtable_min_nodes   = var.tamr_bigtable_min_nodes
    tamr_bigtable_max_nodes   = var.tamr_bigtable_max_nodes
    # dataproc
    tamr_dataproc_project_id = local.tamr_dataproc_project_id
    tamr_dataproc_region     = var.tamr_dataproc_region
    # NOTE: indent does not indent the first line of a variable, so we prefix it
    # with a new file
    tamr_dataproc_cluster_config = indent(2, "\n${local.dataproc_config}")
    tamr_dataproc_bucket         = var.tamr_dataproc_bucket
    # spark
    tamr_spark_driver_memory      = var.tamr_spark_driver_memory
    tamr_spark_executor_memory    = var.tamr_spark_executor_memory
    tamr_spark_executor_cores     = var.tamr_spark_executor_cores
    tamr_spark_executor_instances = var.tamr_spark_executor_instances
    # ditto, comment about indent() above
    tamr_spark_properties_override = indent(4, "\n${local.spark_properties}")
    # sql
    tamr_cloud_sql_project  = local.tamr_cloud_sql_project
    tamr_cloud_sql_location = var.tamr_cloud_sql_location
    tamr_cloud_sql_name     = var.tamr_cloud_sql_name
    tamr_sql_user           = var.tamr_sql_user
    tamr_sql_password       = var.tamr_sql_password
    # elastic
    remote_es                = local.remote_es
    tamr_es_enabled          = var.tamr_es_enabled
    tamr_es_apihost          = local.tamr_es_apihost
    tamr_es_user             = var.tamr_es_user
    tamr_es_password         = var.tamr_es_password
    tamr_es_ssl_enabled      = var.tamr_es_ssl_enabled
    tamr_es_number_of_shards = var.tamr_es_number_of_shards
    tamr_es_socket_timeout   = var.tamr_es_socket_timeout
    # file system
    tamr_filesystem_bucket = var.tamr_filesystem_bucket
    # miscellaneous
    tamr_license_key  = var.tamr_license_key
    tamr_json_logging = var.tamr_json_logging
  })

  startup_script = templatefile("${path.module}/templates/startup_script.sh.tmpl", {
    tamr_zip_uri        = var.tamr_zip_uri
    tamr_config         = local.tamr_config
    tamr_home_directory = var.tamr_instance_install_directory
  })

  shutdown_script = templatefile("${path.module}/templates/shutdown_script.sh.tmpl", {
    tamr_home_directory = var.tamr_instance_install_directory
  })
}

# NOTE: upload rendered startup script to gcs for 2 reasons
# 1) so sensitive config, like passwords are not viewable from the VM meta-data directly in the console
# 2) to work around script limit sizes
resource "google_storage_bucket_object" "startup_script" {
  name    = "tamr_gcp_startup_${md5(local.startup_script)}.sh"
  content = local.startup_script
  bucket  = var.tamr_filesystem_bucket
}

resource "google_storage_bucket_object" "shutdown_script" {
  name    = "tamr_gcp_shutdown.sh"
  content = local.shutdown_script
  bucket  = var.tamr_filesystem_bucket
}

resource "google_compute_address" "tamr_ip" {
  name         = "${var.tamr_instance_name}-ip"
  subnetwork   = var.tamr_instance_subnet
  address_type = "INTERNAL"
}

resource "google_compute_address" "external_ip" {
  count        = local.external_ip
  name         = var.tamr_instance_name
  address_type = "EXTERNAL"
}

# tamr vm
resource "google_compute_instance" "tamr" {
  name                = var.tamr_instance_name
  machine_type        = var.tamr_instance_machine_type
  zone                = var.tamr_instance_zone
  project             = var.tamr_instance_project
  deletion_protection = var.tamr_instance_deletion_protection

  boot_disk {
    initialize_params {
      image = var.tamr_instance_image
      size  = var.tamr_instance_disk_size
      type  = var.tamr_instance_disk_type
    }
  }

  network_interface {
    subnetwork = var.tamr_instance_subnet
    network_ip = google_compute_address.tamr_ip.address

    dynamic "access_config" {
      for_each = google_compute_address.external_ip
      content {
        nat_ip = access_config.value.address
      }
    }
  }

  tags = var.tamr_instance_tags

  labels = merge(
    var.labels,
    { "role" = "tamr" },
  )

  service_account {
    scopes = ["cloud-platform"]
    email  = var.tamr_instance_service_account
  }

  metadata = {
    shutdown-script-url = "gs://${var.tamr_filesystem_bucket}/${google_storage_bucket_object.shutdown_script.name}"
  }

  # NOTE: we are using the startup_script field instead of the `startup-script-url` pair in metadata, in order to force
  # a recreation of the tamr VM after a configuration change. We want the tamr vm to be fully declarative and to not be
  # a pet vm.
  metadata_startup_script = <<-EOF
#! /bin/bash

gsutil cp gs://${var.tamr_filesystem_bucket}/${google_storage_bucket_object.startup_script.name} /tmp/startup_script.sh
/bin/bash /tmp/startup_script.sh

EOF

  allow_stopping_for_update = true
}
