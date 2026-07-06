variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "us-east-1"
  }

  variable "ami_id" {
    description = "Amazon Linux 2 AMI ID"
    type        = string
    default     = "ami-0c02fb55956c7d316"  # Amazon Linux 2 in us-east-1
  }

  variable "key_name" {
    description = "SSH key pair name (must exist in AWS)"
    type        = string
  }

  Create outputs.tf:

  hcl
  output "ssh_connection" {
    value = "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.demo.public_ip}"
  }

  output "web_url" {
    value = "http://${aws_instance.demo.public_ip}"
  }
