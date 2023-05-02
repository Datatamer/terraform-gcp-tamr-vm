# GCP Tamr VM module

## v2.2.1 - May 2nd 2023
* Adjust condition in startup script to expect a string

## v2.2.0 - May 1st 2023
* Following optional input variables now available
  * pre_install_bash
* Allow users to supply custom script to prepare VM

## v2.1.1 - April 28th 2023
* Startup script checks for the correct unify start script
* Startup script avoids permission errors in creating custom config


## v2.1.0 - April 25th 2023
* Following optional input variables now available
  * metadata
* Allows flexibility for the user of this module to supply custom metadata
* Creates configuration file as Tamr functional user to avoid permissions issues

## v2.0.0 - July 18th 2022
* Remove overlap with config module

## v1.0.0 - June 1st 2022
* Set minimum terraform to 1.0.0 and minimum google provider to 4.6.0

## v0.5.0 - October 4th 2021
* Sets TAMR_BACKUP_GSUTIL_ENABLED explicitly to true

## v0.4.1 - August 31st 2021
* Updates dataproc workflow template to remove use of public initialization script
* Bumps dataproc version to 1.4

## v0.3.1 - August 4nd 2021
* Correct content of shutdown-script resource

## v0.3.0 - August 2nd 2020
* Added support for external IPs
* Added support for deletion protection

## v0.2.1 - August 6th 2020
* Add zone/region flags into dataproc workflow template

## v0.2.0 - August 4th 2020
* Upgrade to spark 2.4
* Pin GCS connector version
* Use default spark event log directory

## v0.1.0 - July 28th 2020
* Initing project
