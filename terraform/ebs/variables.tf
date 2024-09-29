variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project-prefix" {
  description = "project name"
  type = string
  default = "eks-service"
}