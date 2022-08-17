<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| filesystem\_bucket | n/a | `string` | n/a | yes |
| project\_id | n/a | `string` | n/a | yes |
| subnet\_name | n/a | `string` | n/a | yes |
| instance\_id | n/a | `string` | `"tamr-vm-example"` | no |
| instance\_image | n/a | `string` | `"tamr-private-images/bionic-base-1644877703"` | no |
| region\_id | n/a | `string` | `"us-east1"` | no |
| service\_account | n/a | `string` | `""` | no |
| zip\_url | n/a | `string` | `"gs://tamr-releases/v2022.005.0/unify.zip"` | no |
| zone\_id | n/a | `string` | `"us-east1-b"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
