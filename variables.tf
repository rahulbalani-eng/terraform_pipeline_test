variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0c02fb55956c7d316"  # Update for your region
}

variable "key_name" {
  description = "SSH key pair name"
}
