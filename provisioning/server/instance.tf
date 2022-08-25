resource "aws_instance" "foundry" {
  ami = data.aws_ami.foundry.id
  instance_type = "t3.small"
  availability_zone = var.availability_zone
  iam_instance_profile = aws_iam_role.instance_role.name
  key_name = var.key_name
  vpc_security_group_ids = [
    aws_security_group.foundry_instance.id,
    aws_security_group.efs.id,
    data.aws_security_group.user_access.id
  ]

  user_data = file("${path.module}/resources/user_data.sh")

  tags = {
    "Name" = "Foundry Instance"
    "AUTO_DNS_ZONE" = aws_route53_zone.main.id
    "AUTO_DNS_NAME" = data.aws_ssm_parameter.app_hostname.value
  }
}