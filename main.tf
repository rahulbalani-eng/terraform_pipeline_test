terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
  }

  provider "aws" {
    region = "us-east-1"
  }

  resource "aws_security_group" "test_sg" {
    name        = "iacm-state-test-sg"
    description = "Security group for IaCM state ops testing"

    ingress {
      from_port   = 22
      to_port     = 22
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

  resource "aws_instance" "web" {
    ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2 us-east-1
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.test_sg.id]

    tags = {
      Name = "iacm-state-test"
      Env  = "dev"
    }
  }

  resource "aws_instance" "db" {
    ami           = "ami-0c02fb55956c7d316"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.test_sg.id]

    tags = {
      Name = "iacm-state-test-db"
      Env  = "dev"
    }
  }
