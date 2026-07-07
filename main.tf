terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
      }
      random = {
        source  = "hashicorp/random"
        version = "~> 3.0"
      }
    }
  } 

  provider "aws" {
    region = "us-east-1"
  }

  resource "random_id" "suffix" {
    byte_length = 4
  }

  resource "aws_security_group" "test_sg" {
    name        = "iacm-state-test-sg-${random_id.suffix.hex}"
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
  
    tags = {
      Name = "iacm-state-test"
    }
  } 
  
  resource "aws_instance" "web" {
    ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2 us-east-1
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.test_sg.id]

    tags = { 
      Name = "iacm-state-test-web"
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
