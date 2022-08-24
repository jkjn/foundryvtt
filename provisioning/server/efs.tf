resource "aws_efs_file_system" "userdata" {
  availability_zone_name = var.availability_zone
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"

  lifecycle_policy {
    transition_to_ia = "AFTER_60_DAYS"
  }

  tags = {
    Name = "foundryuserdata"
  }
}

resource "aws_efs_mount_target" "userdata" {
  file_system_id = aws_efs_file_system.userdata.id
  subnet_id = data.aws_subnet.efs.id
  security_groups = [
    aws_security_group.efs.id
  ]
}

resource "aws_ssm_parameter" "efs_dns" {
  name = "/foundry/efs_domain_name"
  description = "Domain Name for the Foundry User Data EFS Volume"
  type = "SecureString"
  value = aws_efs_file_system.userdata.dns_name
}