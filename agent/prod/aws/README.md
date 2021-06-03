## Requirements
### Tools
 - terraform >= 15

### Environment variables
 - AWS_ACCESS_KEY_ID - AWS key id.
 - AWS_SECRET_ACCESS_KEY - AWS secret key.

### Required terraform variables (terraform.tfvars or other)
 - ssh_public_key - Public key that will be used to ssh the instance.
 - scalr_token - agent configuration value. Can be retrieved by creating agent-pool token in the Scalr UI.
 - scalr_url - agent configuration value. The URL of the Scalr server.
 - owner - your Scalr username (<username>@scalr.com). Required for Revizor.
