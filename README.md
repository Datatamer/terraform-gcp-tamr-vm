# terraform-gcp-tamr-vm
This modules launches and configures a tamr VM in gcp. If all the inputs are given it will configure the tamr vm to use gcp scale out services.
This repo follows the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
## Minimal
Smallest complete fully working example. This example might require extra resources to run the example.
- [Minimal](https://github.com/Datatamer/terraform-gcp-tamr-vm/tree/master/examples/minimal)

# Resources Created
This modules creates:
* a VM instance in order to run Tamr

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| google | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| tamr\_config\_file | Override generated tamr configuration. The tamr configuration is specified using a yaml file, in the format that is documented (https://docs.tamr.com/previous/docs/configuration-configuring-unify#section-setting-configuration-variables) for configuring “many variables” at once. | `string` | n/a | yes |
| tamr\_filesystem\_bucket | GCS bucket to use for the tamr default file system | `string` | n/a | yes |
| tamr\_instance\_image | Image to use for boot disk | `string` | n/a | yes |
| tamr\_instance\_project | The project to launch the tamr VM instance in. | `string` | n/a | yes |
| tamr\_instance\_service\_account | email of service account to attach to the tamr instance | `string` | n/a | yes |
| tamr\_instance\_subnet | subnetwork to attach instance too | `string` | n/a | yes |
| tamr\_instance\_zone | zone to deploy tamr vm | `string` | n/a | yes |
| tamr\_zip\_uri | gcs location to download tamr zip from | `string` | n/a | yes |
| labels | labels to attach to created resources | `map(string)` | `{}` | no |
| metadata | custom metadata to attach to created VM | `map(string)` | `{}` | no |
| pre\_install\_bash | Bash to be run before Tamr is installed.<br>  Likely to be used to meet Tamr's prerequisites, if not already met by the image. (https://docs.tamr.com/new/docs/requirements )<br>   This will only be run once before Tamr is installed, unless Tamr fails to install. This bash will also be run on subsequent attempts to install Tamr, so it is recommended that this bash is idempotent. | `string` | `""` | no |
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
