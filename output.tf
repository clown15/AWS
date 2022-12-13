output "public_ip" {
  value       = [aws_instance.ec2.*.public_ip]
  description = "The public IP of the instance"
}
output "public_dns" {
  value       = [aws_instance.ec2.*.public_dns]
  description = "The public DNS of the instance"
}
output "private_ip" {
  value       = [aws_instance.ec2.*.private_ip]
  description = "The private IP of the instance"
}