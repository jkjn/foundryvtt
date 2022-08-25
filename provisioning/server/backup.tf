resource "aws_backup_vault" "efs" {
  name = "foundry_user_data"
  tags = {
    "Name" = "Foundry User Data"
  }
}

resource "aws_backup_plan" "efs" {
  name = "efs_userdata_backup"

  rule {
    rule_name         = "efs_userdata_backup"
    target_vault_name = aws_backup_vault.efs.name
    schedule          = "cron(0 3 ? * 1 *)"

    lifecycle {
      cold_storage_after = 30
      delete_after = 120
    }
  }
}

resource "aws_backup_selection" "efs" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = "efs_userdata_backup"
  plan_id      = aws_backup_plan.efs.id

  resources = [
    aws_efs_file_system.userdata.arn,
  ]
}