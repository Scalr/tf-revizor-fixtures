## Requirements
### Tools
 - gcloud (for retrieving package name from the bucket)
 - pyopenssl python package (for gcloud signurl)
 - terraform >= 15

### Environment variables
 - GOOGLE_CREDENTIALS - path or content of the service account file.
 - GOOGLE_PROJECT - google project

### Required terraform variables (terraform.tfvars or other)
 - ssh_public_key - Public key that will be used to ssh the instance.
 - ssh_user - SSH username (could be your local username).
 - scalr_token - agent configuration value. Can be retrieved by creating agent-pool token in the Scalr UI.
 - scalr_url - agent configuration value. The URL of the Scalr server.
 - owner - your Scalr username (<username>@scalr.com). Required for Revizor.


## Installation from branch

In order to install agent from branch:
 - Set `omnibus` label for PR. Ensure the package is built.
 - Set `branch` terraform variable for this workspace in format: `feature-scalrcore-<ticket-num>`
