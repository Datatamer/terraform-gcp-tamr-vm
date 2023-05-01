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

variable "tamr_instance_deletion_protection" {
  type        = bool
  description = "Enabled deletion protection for the tamr VM"
  default     = true
}

variable "tamr_external_ip" {
  type        = bool
  description = "Create and attach an external ip to tamr VM"
  default     = false
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
# miscellaneous
#
variable "labels" {
  default     = {}
  type        = map(string)
  description = "labels to attach to created resources"
}

variable "metadata" {
  default     = {}
  type        = map(string)
  description = "custom metadata to attach to created VM"
}

variable "tamr_config_file" {
  type        = string
  description = "Override generated tamr configuration. The tamr configuration is specified using a yaml file, in the format that is documented (https://docs.tamr.com/previous/docs/configuration-configuring-unify#section-setting-configuration-variables) for configuring “many variables” at once."
}

variable "pre_start_script_content" {
  default     = ""
  type        = string
  description = "custom script to run prior to startup_script"
}

#
# file system
#
variable "tamr_filesystem_bucket" {
  type        = string
  description = "GCS bucket to use for the tamr default file system"
}
