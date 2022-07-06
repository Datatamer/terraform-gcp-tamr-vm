# Tamr VM
output "tamr_instance_self_link" {
  value       = google_compute_instance.tamr.self_link
  description = "full self link of created tamr vm"
}

output "tamr_instance_internal_ip" {
  value       = google_compute_address.tamr_ip.address
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

output "tmpl_startup_script" {
  value       = local.startup_script
  description = "rendered metadata startup script"
}
