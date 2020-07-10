output "tamr_config_file" {
  value       = local.tamr_config
  description = "full tamr config file"
}

output "tmpl_dataproc_config" {
  value       = local.default_dataproc
  description = "dataproc config"
}
