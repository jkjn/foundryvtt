resource "aws_security_group" "foundry_instance" {
  name = "foundry-instance"
  description = "Security group allowing ingress to the instance"

  ingress {
    description = "Default traffic on port 30000"
    from_port = 30000
    to_port   = 30000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Traffic on port 443"
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Foundry Instance SG"
  }
}

resource "aws_security_group" "efs" {
  name = "foundry-efs"
  description = "Security group allowing traffic to and from efs"

  ingress {
    description = "NFS traffic"
    from_port = 2049
    to_port   = 2049
    protocol = "tcp"
    self = true
  }

  egress {
    description = "Outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Foundry EFS"
  }
}

# security groups to ssm