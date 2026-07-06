terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Free-tier eligible t2.micro instance
resource "aws_instance" "demo" {
  ami           = var.ami_id
  instance_type = "t2.micro"  # Free tier eligible
  key_name      = var.key_name

  tags = {
    Name = "ansible-demo-instance"
  }

  # Output the public IP for Ansible inventory
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory.txt"
  }
}

output "instance_ip" {
  value = aws_instance.demo.public_ip
}
