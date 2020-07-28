#
# Tamr VM
#
variable "tamr_instance_name" {
  default     = "tamr"
  type        = string
  description = "Name of the VM running tamr"
}

variable "tamr_instance_machine_type" {
  default     = "n1-highmem-8"
  type        = string
  description = "machine type to use for tamr vm"
}

variable "tamr_instance_zone" {
  type        = string
  description = "zone to deploy tamr vm"
}

# NOTE: for right now requiring this to be set, in the future will use either
# a publish tamr image or a default ubuntu image
variable "tamr_instance_image" {
  type        = string
  description = "Image to use for boot disk"
}

variable "tamr_instance_disk_type" {
  default     = "pd-ssd"
  type        = string
  description = "boot disk type"
}

variable "tamr_instance_disk_size" {
  default     = 100
  type        = number
  description = "size of the boot disk"
}

variable "tamr_instance_service_account" {
  type        = string
  description = "email of service account to attach to the tamr instance"
}

variable "tamr_instance_subnet" {
  type        = string
  description = "subnetwork to attach instance too"
}

variable "tamr_instance_project" {
  type        = string
  description = "The project to launch the tamr VM instance in."
}

variable "tamr_instance_tags" {
  default     = []
  type        = list(string)
  description = "list of network tags to attach to instance"
}

variable "tamr_instance_install_directory" {
  # Get it?, DataTamer :p
  default     = "/data/tamr"
  type        = string
  description = "directory to install tamr into"
}

variable "tamr_zip_uri" {
  type        = string
  description = "gcs location to download tamr zip from"
}

#
# Bigtable
#
variable "tamr_hbase_namespace" {
  default     = "ns0"
  type        = string
  description = "HBase namespace to user, for bigtable this will be the table prefix."
}

variable "tamr_bigtable_project_id" {
  default     = ""
  type        = string
  description = "The google project that the bigtable instance lives in. If not set will use the tamr_instance_project as the default value. "
}

variable "tamr_bigtable_instance_id" {
  type        = string
  description = "Bigtable instance ID"
}

variable "tamr_bigtable_cluster_id" {
  type        = string
  description = "Bigtable cluster ID"
}

variable "tamr_bigtable_min_nodes" {
  type        = string
  description = "Min number of nodes to scale down to"
}

variable "tamr_bigtable_max_nodes" {
  type        = string
  description = "Max number of nodes to scale up to"
}
#
# dataproc
#
variable "tamr_dataproc_project_id" {
  default     = ""
  type        = string
  description = "Project for the dataproc cluster. If not set will use the tamr_instance_project as the default value. "
}

variable "tamr_dataproc_bucket" {
  type        = string
  description = "GCS bucket to use for the tamr dataproc cluster"
}

variable "tamr_dataproc_region" {
  type        = string
  description = "Region the dataproc uses."
}

variable "tamr_dataproc_cluster_config" {
  default     = ""
  type        = string
  description = <<-EOF
If you do not want to use the default dataproc configuration template, pass in a complete dataproc configuration file to variable.
If you are passing in a dataproc configure it should not be left padded, we will handle that inside of our template. It is expected to
a yaml document of a dataproc cluster config
Refrence spec is https://cloud.google.com/dataproc/docs/reference/rest/v1/ClusterConfig
EOF
}

# dataproc cluster configuration values
# These are only used if using the built in tamr_dataproc_cluster_config configuration
variable "tamr_dataproc_cluster_subnetwork_uri" {
  default     = ""
  type        = string
  description = "Subnetwork URI for dataproc to use. If not set will use the tamr_instance_subnet as the default value. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

variable "tamr_dataproc_cluster_service_account" {
  default     = ""
  type        = string
  description = "Service account to attach to dataproc workers. If not set will use the tamr_instance_service_account as the default value. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

variable "tamr_dataproc_cluster_zone" {
  default     = ""
  type        = string
  description = "Zone to launch dataproc cluster into. If not set will use the tamr_instance_zone as the default value. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

variable "tamr_dataproc_cluster_enable_stackdriver_logging" {
  default     = true
  type        = bool
  description = "Enabled stackdriver logging on dataproc clusters. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

variable "tamr_dataproc_cluster_version" {
  default     = "1.3"
  type        = string
  description = "Version of dataproc to use. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

# master node
variable "tamr_dataproc_cluster_master_instance_type" {
  default     = "n1-highmem-4"
  type        = string
  description = "Instance type to use as dataproc master This only used if using the built in tamr_dataproc_cluster_config configuration"
}

variable "tamr_dataproc_cluster_master_disk_size" {
  default     = 1000
  type        = number
  description = "Size of disk to use on dataproc master disk This only used if using the built in tamr_dataproc_cluster_config configuration"
}

# work nodes
variable "tamr_dataproc_cluster_worker_machine_type" {
  default     = "n1-standard-16"
  type        = string
  description = "machine type of default worker pool. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

variable "tamr_dataproc_cluster_worker_num_instances" {
  default     = 4
  type        = number
  description = "Number of default workers to use. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

variable "tamr_dataproc_cluster_worker_num_local_ssds" {
  default     = 2
  type        = number
  description = "Number of localssds to attach to each worker node. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

variable "tamr_dataproc_cluster_worker_preemptible_machine_type" {
  default     = "n1-standard-16"
  type        = string
  description = "machine type of preemptible worker pool. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

variable "tamr_dataproc_cluster_worker_preemptible_num_instances" {
  default     = 0
  type        = number
  description = "Number of preemptible workers to use. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

variable "tamr_dataproc_cluster_worker_preemptible_num_local_ssds" {
  default     = 2
  type        = number
  description = "Number of localssds to attach to each preemptible worker node. This only used if using the built in tamr_dataproc_cluster_config configuration"
}

# spark settings
variable "tamr_spark_driver_memory" {
  default     = "12G"
  type        = string
  description = "Amount of memory spark should allocate to spark driver"
}

variable "tamr_spark_executor_memory" {
  default     = "13G"
  type        = string
  description = "Amount of memory spark should allocate to each spark executor"
}

variable "tamr_spark_executor_cores" {
  default     = 5
  type        = number
  description = "Amount of cores spark should allocate to each spark executor"
}

variable "tamr_spark_executor_instances" {
  default     = 12
  type        = number
  description = "number of spark executor instances"
}

variable "tamr_spark_properties_override" {
  default     = ""
  type        = string
  description = "json blob of spark properties to override, if not set will use a default set of properties that should work for most use cases"
}

#
# Cloud SQL (PostgreSQL)
#
variable "tamr_cloud_sql_project" {
  default     = ""
  type        = string
  description = "project containing cloudsql instance. If not set will use the tamr_instance_project as the default value."
}

variable "tamr_cloud_sql_location" {
  type        = string
  description = "location for cloud sql instance. NOTE: this is either a region or a zone."
}

variable "tamr_cloud_sql_name" {
  type        = string
  description = "name of cloud sql instance"
}

variable "tamr_sql_user" {
  default     = "tamr"
  type        = string
  description = "username for the cloud sql user"
}

variable "tamr_sql_password" {
  type        = string
  description = "password for the cloud sql user"
}

#
# elasticsearch
#
variable "tamr_es_enabled" {
  default     = true
  type        = bool
  description = "Whether Tamr will index user data in Elasticsearch or not.  Elasticsearch is used to power Tamr's interactive data UI, so when this is set to false Tamr will run 'headless,' that is, without its core UI capabilities.  It can be useful to disable Elasticsearch in production settings where the models are trained on a separate instance and the goal is to maximize pipeline throughput."
}

variable "tamr_es_apihost" {
  default     = ""
  type        = string
  description = "The hostname and port of the REST API endpoint of the Elasticsearch cluster to use. If unset will use < ip of vm>:9200"
}

variable "tamr_es_user" {
  default     = ""
  type        = string
  description = "Username to use to authenticate to Elasticsearch.  Not required unless the Elasticsearch cluster you're using has security and authentication enabled."
}

variable "tamr_es_password" {
  default     = ""
  type        = string
  description = "Password to use to authenticate to Elasticsearch, using basic authentication.  Not required unless the Elasticsearch cluster you're using has security and authentication enabled.  The value passed in may be encrypted."
}

variable "tamr_es_ssl_enabled" {
  default     = false
  type        = bool
  description = "Whether to connect to Elasticsearch over https or not.  Default is false (http)."
}

variable "tamr_es_number_of_shards" {
  default     = 1
  type        = number
  description = "The number of shards to set when creating the Tamr index in Elasticsearch.  Default value is the number of cores on the local host machine, so this should be overridden when using a remote Elasticsearch cluster.  Note: this value is only applied when the index is created."
}

variable "tamr_es_socket_timeout" {
  default     = 900000
  type        = number
  description = "Defines the socket timeout for Elasticsearch clients, in milliseconds. This is the timeout for waiting for data or, put differently, a maximum period of inactivity between two consecutive data packets. A timeout value of zero is interpreted as an infinite timeout. A negative value is interpreted as undefined (system default).  The default value is 900000, i.e., fifteen minutes."
}

#
# miscellaneous
#
variable "tamr_license_key" {
  default     = ""
  type        = string
  description = "Set a tamr license key"
}

variable "tamr_json_logging" {
  default     = false
  type        = bool
  description = "Toggle json formatting for tamr logs."
}

variable "labels" {
  default     = {}
  type        = map(string)
  description = "labels to attach to created resources"
}

#
# file system
#

variable "tamr_filesystem_bucket" {
  type        = string
  description = "GCS bucket to use for the tamr default file system"
}
