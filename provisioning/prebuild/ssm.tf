resource "aws_ssm_parameter" "app_hostname" {
  name = "/foundry/app_hostname"
  type = "SecureString"
  value = "dnd.${var.root_dns}"
}