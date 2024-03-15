output "instance_ip_addr_1" {
  value       = aws_instance.web[0].private_ip
}

output "instance_ip_addr_2" {
  value       = aws_instance.web[1].private_ip
}

output "instance_ip_addr_3" {
  value       = aws_instance.web[2].private_ip
}