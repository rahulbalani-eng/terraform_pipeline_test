terraform {
    required_version = ">= 1.0"
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
  }

  provider "aws" {
    region = var.aws_region
  }

  # Security group for SSH and HTTP
  resource "aws_security_group" "demo" {
    name        = "ansible-demo-sg"
    description = "Allow SSH and HTTP"

    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Free tier t2.micro instance
  resource "aws_instance" "demo" {
    ami                    = var.ami_id
    instance_type          = "t2.micro"
    key_name               = var.key_name
    vpc_security_group_ids = [aws_security_group.demo.id]

    tags = {
      Name = "ansible-demo-server"
      Environment = "demo"
    }

    # Wait for instance to be ready
    provisioner "local-exec" {
      command = "sleep 30"
    }
  }

  # Output for Ansible
  output "instance_public_ip" {
    value       = aws_instance.demo.public_ip
    description = "Public IP of the EC2 instance"
  }

  output "instance_id" {
    value = aws_instance.demo.id
  }
