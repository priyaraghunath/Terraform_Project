variable "ami_id" {}
variable "instance_type" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_id" {}
