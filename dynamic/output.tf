output "vpc_id" {
  value = aws_vpc.hands_on_vpc.id
}

output "subnet_id" {
  value = aws_subnet.megazone_public_1a.id
}
