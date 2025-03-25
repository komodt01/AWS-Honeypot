output "instance_public_ip" {
  description = "Public IP address of the honeypot EC2 instance"
  value       = aws_instance.honeypot.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.honeypot.id
}

output "vpc_id" {
  description = "ID of the custom VPC"
  value       = aws_vpc.honeypot_vpc.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = aws_subnet.honeypot_subnet.id
}
