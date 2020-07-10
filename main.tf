locals {
  #dataproc_config  = var.tamr_dataproc_cluster_config == "" ? data.template_file.dataproc[0].rendered : var.tamr_dataproc_cluster_config
  dataproc_config = var.tamr_dataproc_cluster_config == "" ? local.default_dataproc : var.tamr_dataproc_cluster_config

  spark_properties = var.tamr_spark_properties_override == "" ? file("${path.module}/spark_properties.json") : var.tamr_spark_properties_override

  default_dataproc = templatefile("${path.module}/dataproc.yaml.tmpl", {
    subnetwork_uri       = var.tamr_dataproc_cluster_subnetwork_uri
    service_account      = var.tamr_dataproc_cluster_service_account
    zone                 = var.tamr_dataproc_cluster_zone
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


  tamr_config = templatefile("${path.module}/tamr_config.yaml.tmpl", {
    # Bigtable
    tamr_hbase_namespace      = var.tamr_hbase_namespace
    tamr_bigtable_project_id  = var.tamr_bigtable_project_id
    tamr_bigtable_instance_id = var.tamr_bigtable_instance_id
    tamr_bigtable_cluster_id  = var.tamr_bigtable_cluster_id
    tamr_bigtable_min_nodes   = var.tamr_bigtable_min_nodes
    tamr_bigtable_max_nodes   = var.tamr_bigtable_max_nodes
    # dataproc
    tamr_dataproc_project_id = var.tamr_dataproc_project_id
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
    tamr_cloud_sql_project  = var.tamr_cloud_sql_project
    tamr_cloud_sql_location = var.tamr_cloud_sql_location
    tamr_cloud_sql_name     = var.tamr_cloud_sql_name
    tamr_sql_user           = var.tamr_sql_user
    tamr_sql_password       = var.tamr_sql_password
    # elastic
    tamr_es_enabled          = var.tamr_es_enabled
    tamr_es_apihost          = var.tamr_es_apihost
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
}
