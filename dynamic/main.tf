resource "aws_vpc" "hands_on_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "megazone_public_1a" {
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.hands_on_vpc.id
  availability_zone = "ap-northeast-2a"
  cidr_block = "10.0.0.0/24"
  tags = {
    "Name" = "megazone_public_1a"
  }
}

resource "aws_security_group" "hands_on_sg" {
  name = "dynamic_ex"

  vpc_id = aws_vpc.hands_on_vpc.id

  dynamic "ingress" {
    for_each = var.ingresses
    content {
        description = "${ingress.key}"
        from_port = lookup(ingress.value, "from_port", 0)
        to_port = lookup(ingress.value, "to_port", 0)
        protocol = lookup(ingress.value, "protocol", "-1")
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  dynamic "egress" {
    for_each = var.egresses
    content {
        description = "${egress.key}"
        from_port = lookup(egress.value, "from_port", 0)
        to_port = lookup(egress.value, "to_port", 0)
        protocol = lookup(egress.value, "protocol", "-1")
        cidr_blocks = [ "0.0.0.0/0" ] 
    }
  }
}