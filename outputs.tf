# Tamr VM
output "tamr_instance_self_link" {
  value       = google_compute_instance.tamr.self_link
  description = "full self link of created tamr vm"
}

output "tamr_instance_internal_ip" {
  value       = google_compute_instance.tamr.network_interface.0.network_ip
  description = "internal ip of tamr vm"
}

output "tamr_instance_name" {
  value       = google_compute_instance.tamr.name
  description = "name of the tamr vm"
}

output "tamr_instance_zone" {
  value       = google_compute_instance.tamr.zone
  description = "zone of the tamr vm"
}

# config files
# NOTE: these are very useful for debugging
output "tamr_config_file" {
  value       = local.tamr_config
  description = "full tamr config file"
}

output "tmpl_dataproc_config" {
  value       = local.default_dataproc
  description = "dataproc config"
}
