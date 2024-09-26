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
  cluster_name = "${var.project-prefix}-${random_string.suffix.result}"
  admin_user_arn= "${var.admin_user_arn}"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.2"

  cluster_name    = local.cluster_name
  cluster_version = "1.30"

  vpc_id         = var.vpc_id
  subnet_ids     = var.subnet_ids
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_ARM_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"
      instance_types = ["m7g.large"]
      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }

  # Add Access Entry for IAM Admin User
  access_entries = {
    user_entry = {
      kubernetes_groups = []
      principal_arn = local.admin_user_arn

      policy_associations = {
        cluster = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
  
}

resource "aws_ec2_tag" "elb_public_tag" {
  depends_on = [ module.eks ]
  for_each    = toset(var.subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
} 

resource "aws_ec2_tag" "elb_private_tag" {
  depends_on = [ module.eks ]
  for_each    = toset(var.subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
} 

resource "aws_ec2_tag" "elb_common_tag" {
  depends_on = [ module.eks ]
  for_each    = toset(var.subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/cluster/${local.cluster_name}"
  value       = "owned"
} 