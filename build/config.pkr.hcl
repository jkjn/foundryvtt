packer {
  required_plugins {
    amazon-ami-maanagement = {
      version = ">= 1.0.0"
      source  = "github.com/wata727/amazon-ami-management"
    }

    amazon = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/amazon"
    }

    ansible = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}