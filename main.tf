locals {
  external_ip = var.tamr_external_ip == true ? 1 : 0

  startup_script = templatefile("${path.module}/templates/startup_script.sh.tmpl", {
    tamr_zip_uri        = var.tamr_zip_uri
    tamr_config         = var.tamr_config_file
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
