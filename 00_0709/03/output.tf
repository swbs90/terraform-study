output "nomad_server_ip" {
  value = aws_instance.httpd_ec2.public_ip
}