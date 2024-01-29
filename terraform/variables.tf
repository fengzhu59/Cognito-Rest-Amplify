# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-west-1"
}

variable "aws_profile" {
  description = "AWS profile used by terraform to create/destroy resources"

  type    = string
  default = "xd-sso-internal-tools-admin"
}