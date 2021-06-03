variable "gcp_project" {
  type    = string
  default = "development-156220"
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone where all infrastructure will be created."
  default     = "us-central1-a"
}

variable "gcp_region" {
  type        = string
  description = "GCP region where all infrastructure will be created."
  default     = "us-central1"
}

variable "gcp_bucket" {
  type        = string
  description = "Bucket with scalr-agent package."
  default     = "fatmouse"
}

variable "gcp_machine_type" {
  type        = string
  description = "GCP machine type"
  default     = "n1-standard-1"
}

variable "ssh_public_key" {
  type        = string
  description = "The public key that will be used to ssh the instance. If empty - no ssh key will be added."
  default     = ""
}

variable "ssh_user" {
  type        = string
  description = "The public key that will be used to ssh the instance. If empty - no ssh key will be added."
  default     = ""
}

variable "owner" {
  type        = string
  description = "Instance owner. <owner>@scalr.com. Dots must be replaced with _"
}

variable "agents_count" {
  type        = number
  description = "Number of agents to spawn."
  default     = 1
}


# Agent configuration

variable "branch" {
  type        = string
  description = "Fatmouse branch to install scalr-agent from. Default is master."
  default     = "master"
}

variable "scalr_agent_name" {
  type        = string
  description = "Agent name."
  default     = "$(hostname)"
}

variable "scalr_token" {
  type        = string
  description = "Agent pool token."
}

variable "scalr_url" {
  type        = string
  description = "Scalr server URL."
}
