# terraform-gcp-tamr-vm
This modules launches and configures a tamr VM in gcp. If all the inputs are given it will configure the tamr vm to use gcp scale out services.
This repo follows the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
This example just outputs a basic tamr configuration file
```
locals {
  gcp_project = "tamr-deployment"
  default_region = "us-east1"
  default_zone = "us-east1-b"
}

module "sample" {
  source = "../"
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
  tamr_sql_password       = "super_secure_password"
  # filesystem
  tamr_filesystem_bucket = "tamr_application_home"
}

output "tamr_config" {
  value = module.sample.tamr_config_file
}
```

# Resources Created
This modules creates:
* a null resource

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| google | >= 4.6.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 4.6.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| tamr\_config\_file | full tamr config file | `string` | n/a | yes |
| tamr\_filesystem\_bucket | GCS bucket to use for the tamr default file system | `string` | n/a | yes |
| tamr\_instance\_image | Image to use for boot disk | `string` | n/a | yes |
| tamr\_instance\_project | The project to launch the tamr VM instance in. | `string` | n/a | yes |
| tamr\_instance\_service\_account | email of service account to attach to the tamr instance | `string` | n/a | yes |
| tamr\_instance\_subnet | subnetwork to attach instance too | `string` | n/a | yes |
| tamr\_instance\_zone | zone to deploy tamr vm | `string` | n/a | yes |
| tamr\_zip\_uri | gcs location to download tamr zip from | `string` | n/a | yes |
| labels | labels to attach to created resources | `map(string)` | `{}` | no |
| tamr\_external\_ip | Create and attach an external ip to tamr VM | `bool` | `false` | no |
| tamr\_instance\_deletion\_protection | Enabled deletion protection for the tamr VM | `bool` | `true` | no |
| tamr\_instance\_disk\_size | size of the boot disk | `number` | `100` | no |
| tamr\_instance\_disk\_type | boot disk type | `string` | `"pd-ssd"` | no |
| tamr\_instance\_install\_directory | directory to install tamr into | `string` | `"/data/tamr"` | no |
| tamr\_instance\_machine\_type | machine type to use for tamr vm | `string` | `"n1-highmem-8"` | no |
| tamr\_instance\_name | Name of the VM running tamr | `string` | `"tamr"` | no |
| tamr\_instance\_tags | list of network tags to attach to instance | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| tamr\_instance\_internal\_ip | internal ip of tamr vm |
| tamr\_instance\_name | name of the tamr vm |
| tamr\_instance\_self\_link | full self link of created tamr vm |
| tamr\_instance\_zone | zone of the tamr vm |
| tmpl\_startup\_script | rendered metadata startup script |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# Development
## Generating Docs
Run `make terraform/docs` to generate the section of docs around terraform inputs, outputs and requirements.

## Checkstyles
Run `make lint`, this will run terraform fmt, in addition to a few other checks to detect whitespace issues.
NOTE: this requires having docker working on the machine running the test

## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
