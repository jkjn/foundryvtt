build {
  name    = "ubuntu-foundry"
  sources = ["source.amazon-ebs.ubuntu-foundry"]

  hcp_packer_registry {
    bucket_name = "foundry-ubuntu"
    description = "Foundry Ubuntu Image"

    bucket_labels = {
      "team" = "development",
      "os"   = "Ubuntu"
    }

    build_labels = {
      "python-version" = "3.9",
      "ubuntu-version" = "Focal 20.04"
      "foundry-version" = "9.269"
      "build-time"     = timestamp()
    }
  }

  provisioner "ansible" {
    extra_arguments = [
        "-v",
        "--extra-vars", "@ansible/config/vars.json"
    ]

    user = "ubuntu"
    playbook_file = "ansible/provision.yaml"
    roles_path = "~/.ansible/roles"
    ansible_env_vars = [
        "ANSIBLE_CONFIG=ansible/config/ansible.cfg"
    ]
  }

  post-processor "amazon-ami-management" {
    regions = ["us-east-2"]
    identifier = "Foundry Image"
    keep_releases = 1
  }
}