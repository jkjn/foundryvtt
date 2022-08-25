resource "aws_iam_role" "instance_role" {
  name = "foundry-server-role"
  assume_role_policy = file("${path.module}/trust/instance_assume_role.json")
}

resource "aws_iam_instance_profile" "instance_role" {
  name = "foundry-server-role"
  role = aws_iam_role.instance_role.name
}

resource "aws_iam_role_policy" "instance_role_policy" {
  name = "instance-role-policy"
  role = aws_iam_role.instance_role.id
  policy = templatefile("${path.module}/policies/instance-role-policy.json", {
    config_bucket_id = "${var.default_prefix}-foundry-config"
    data_bucket_id = aws_s3_bucket.foundry_data.id
    hosted_zone_id = aws_route53_zone.main.id
  })
}

resource "aws_iam_role_policy_attachment" "efs_policy" {
  role = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientReadWriteAccess"
}

resource "aws_iam_role" "backup" {
  name               = "foundry-backup-role"
  assume_role_policy = file("${path.module}/trust/backup_assume_role.json")
}

resource "aws_iam_role_policy_attachment" "backup" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup.name
}
