provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project = "${var.project-prefix}"
    }
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  ebs_vol_name = "${var.project-prefix}-ebs-${random_string.suffix.result}"
}

resource "aws_ebs_volume" "ebs_vol" {
  availability_zone = "${var.region}a"
  size              = 10
  type              = "gp3"

  tags = {
    Name = "${local.ebs_vol_name}",
    Project = "${var.project-prefix}"
  }
}