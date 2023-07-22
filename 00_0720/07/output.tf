/*
  Compute
*/
output "pub_web_ip" {
  description = "access web service"
  value       = "${google_compute_instance.compute_instance.network_interface.0.access_config.0.nat_ip}:${var.service_port}"
}

output "instance_connection_string" {
  description = "Command to connect to the compute instance"
  value       = "ssh -i ${local_file.ssh_private_key_pem.filename} ${var.ssh_user}@${google_compute_instance.compute_bastion.network_interface.0.access_config.0.nat_ip}"
  sensitive   = false
}

output "access_through_bastion" {
  description = "Command to connect to the compute instance with bastion"
  value       = "ssh -i ${local_file.ssh_private_key_pem.filename} ${var.ssh_user}@${google_compute_instance.compute_instance.network_interface.0.network_ip}"
  sensitive   = false
}
