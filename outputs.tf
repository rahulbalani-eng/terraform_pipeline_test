output "ssh_connection" {
    value = "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.demo.public_ip}"
  }

  output "web_url" {
    value = "http://${aws_instance.demo.public_ip}"
  }
