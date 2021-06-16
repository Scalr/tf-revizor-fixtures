terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>3.42.0"
    }
  }

}

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

locals {
  package_name = var.agent_version != null ? join("-", ["scalr-agent", var.agent_version]): "scalr-agent"
}


data "aws_ami" "centos" {
  owners      = ["679593333241"]  # centos organization
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_key_pair" "agent_key" {
  key_name   = "agent_key"
  public_key = var.ssh_public_key

  tags = {
    Owner = var.owner
  }
}

resource "aws_instance" "scalr_agent" {
  ami           = var.aws_instance_ami != null ? var.aws_instance_ami: data.aws_ami.centos.id
  instance_type = var.aws_instance_type
  key_name                    = aws_key_pair.agent_key.key_name
  count = var.agents_count

  user_data = templatefile("install_agent_scalr_repo.bash.tpl", {
    scalr_token=var.scalr_token
    scalr_url=var.scalr_url
    scalr_agent_package_name=local.package_name
    scalr_agent_name="${var.agent_name_prefix}-${count.index}"
  })

  tags = merge(var.extra_tags, {
    Name  = "${var.owner}-scalr-agent-${count.index}"
    Owner = var.owner
  })

}
