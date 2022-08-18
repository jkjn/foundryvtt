source "amazon-ebs" "ubuntu-foundry" {
  region = "us-east-2"
  availability_zone = "us-east-2a"
  instance_type  = "t2.small"
  ami_name = "Foundry Image {{ timestamp }}"

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }

  security_group_ids = split(",", data.amazon-parameterstore.security_groups.value)

  iam_instance_profile = "foundry-packer-builder"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false

  tags = {
    Name = "Foundry Image"
    Amazon_AMI_Management_Identifier = "Foundry Image"
  }
}