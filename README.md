<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0, <6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.0, <6.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.external_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_address.tamr_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_instance.tamr](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_storage_bucket_object.shutdown_script](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.startup_script](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tamr_config_file"></a> [tamr\_config\_file](#input\_tamr\_config\_file) | Override generated tamr configuration. The tamr configuration is specified using a yaml file, in the format that is documented (https://docs.tamr.com/previous/docs/configuration-configuring-unify#section-setting-configuration-variables) for configuring “many variables” at once. | `string` | n/a | yes |
| <a name="input_tamr_filesystem_bucket"></a> [tamr\_filesystem\_bucket](#input\_tamr\_filesystem\_bucket) | GCS bucket to use for the tamr default file system | `string` | n/a | yes |
| <a name="input_tamr_instance_image"></a> [tamr\_instance\_image](#input\_tamr\_instance\_image) | Image to use for boot disk | `string` | n/a | yes |
| <a name="input_tamr_instance_project"></a> [tamr\_instance\_project](#input\_tamr\_instance\_project) | The project to launch the tamr VM instance in. | `string` | n/a | yes |
| <a name="input_tamr_instance_service_account"></a> [tamr\_instance\_service\_account](#input\_tamr\_instance\_service\_account) | email of service account to attach to the tamr instance | `string` | n/a | yes |
| <a name="input_tamr_instance_subnet"></a> [tamr\_instance\_subnet](#input\_tamr\_instance\_subnet) | subnetwork to attach instance too | `string` | n/a | yes |
| <a name="input_tamr_instance_zone"></a> [tamr\_instance\_zone](#input\_tamr\_instance\_zone) | zone to deploy tamr vm | `string` | n/a | yes |
| <a name="input_tamr_zip_uri"></a> [tamr\_zip\_uri](#input\_tamr\_zip\_uri) | gcs location to download tamr zip from | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | labels to attach to created resources | `map(string)` | `{}` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | custom metadata to attach to created VM | `map(string)` | `{}` | no |
| <a name="input_pre_install_bash"></a> [pre\_install\_bash](#input\_pre\_install\_bash) | Bash to be run before Tamr is installed.<br>  Likely to be used to meet Tamr's prerequisites, if not already met by the image. (https://docs.tamr.com/new/docs/requirements )<br>   This will only be run once before Tamr is installed, unless Tamr fails to install. This bash will also be run on subsequent attempts to install Tamr, so it is recommended that this bash is idempotent. | `string` | `""` | no |
| <a name="input_tamr_external_ip"></a> [tamr\_external\_ip](#input\_tamr\_external\_ip) | Create and attach an external ip to tamr VM | `bool` | `false` | no |
| <a name="input_tamr_instance_deletion_protection"></a> [tamr\_instance\_deletion\_protection](#input\_tamr\_instance\_deletion\_protection) | Enabled deletion protection for the tamr VM | `bool` | `true` | no |
| <a name="input_tamr_instance_disk_size"></a> [tamr\_instance\_disk\_size](#input\_tamr\_instance\_disk\_size) | size of the boot disk | `number` | `100` | no |
| <a name="input_tamr_instance_disk_type"></a> [tamr\_instance\_disk\_type](#input\_tamr\_instance\_disk\_type) | boot disk type | `string` | `"pd-ssd"` | no |
| <a name="input_tamr_instance_install_directory"></a> [tamr\_instance\_install\_directory](#input\_tamr\_instance\_install\_directory) | directory to install tamr into | `string` | `"/data/tamr"` | no |
| <a name="input_tamr_instance_machine_type"></a> [tamr\_instance\_machine\_type](#input\_tamr\_instance\_machine\_type) | machine type to use for tamr vm | `string` | `"n1-highmem-8"` | no |
| <a name="input_tamr_instance_name"></a> [tamr\_instance\_name](#input\_tamr\_instance\_name) | Name of the VM running tamr | `string` | `"tamr"` | no |
| <a name="input_tamr_instance_tags"></a> [tamr\_instance\_tags](#input\_tamr\_instance\_tags) | list of network tags to attach to instance | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tamr_instance_internal_ip"></a> [tamr\_instance\_internal\_ip](#output\_tamr\_instance\_internal\_ip) | internal ip of tamr vm |
| <a name="output_tamr_instance_name"></a> [tamr\_instance\_name](#output\_tamr\_instance\_name) | name of the tamr vm |
| <a name="output_tamr_instance_self_link"></a> [tamr\_instance\_self\_link](#output\_tamr\_instance\_self\_link) | full self link of created tamr vm |
| <a name="output_tamr_instance_zone"></a> [tamr\_instance\_zone](#output\_tamr\_instance\_zone) | zone of the tamr vm |
| <a name="output_tmpl_startup_script"></a> [tmpl\_startup\_script](#output\_tmpl\_startup\_script) | rendered metadata startup script |
<!-- END_TF_DOCS -->