variable "aws_region" {
  type = string
  description =  "AWS Region"
  default = "us-east-1"
}

variable "aws_profile" {
  type = string
  description = "AWS Profile"
  default = "default"
}

variable "aws_instance_type" {
  type = string
  description = "AWS instance type."
  default = "t3.small"
}

variable "aws_instance_ami" {
  type = string
  description = "AWS instance AMI. If not set Latest Centos7 will be used."
  default = null
}

variable "owner" {
  type = string
  description = "Workspace owner. Will be written to the AWS instance tags."
}

variable "extra_tags" {
  type = map(string)
  description = "Extra tags. Will be added to the AWS instance tags."
  default = {}
}

variable "ssh_user" {
  type = string
  description = "SSH username."
  default = "centos"
}

variable "ssh_public_key" {
  type = string
  description = "The public key that will be used to ssh the instance."
}

variable "agents_count" {
  type = number
  description = "Number of agents."
  default = 1
}


# Agent configuration

variable "agent_name_prefix" {
  type = string
  description = "Agent name."
  default = "$(hostname)"
}


variable "scalr_token" {
  type = string
  description = "Agent pool token."
}

variable "scalr_url" {
  type = string
  description = "Scalr server URL."
}
