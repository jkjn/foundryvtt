data "aws_ami" "foundry" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = ["Foundry Image*"]
  }
}

data "aws_subnet" "efs" {
  filter {
    name = "availability-zone"
    values = [var.availability_zone]
  }
}

data "aws_security_group" "user_access" {
  filter {
    name = "group-name"
    values = [var.user_access_security_group_name]
  }
}

data "aws_ssm_parameter" "app_hostname" {
  name = "/foundry/app_hostname"
}