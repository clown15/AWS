resource "aws_security_group" "sg" {
  name = var.security_group_name
  vpc_id = aws_vpc.Onboarding-vpc.id
  
  dynamic "ingress" {
    for_each = var.ingresses
    iterator = ing
    content {
      description = "${ing.key}"
      from_port = lookup(ing.value, "from_port", 0)
      to_port = lookup(ing.value, "to_port", 0)
      protocol = lookup(ing.value, "protocol", "-1")
      cidr_blocks = lookup(ing.value, "cidr_blocks", ["0.0.0.0/0"])
    }
  }
  
  dynamic "egress" {
    for_each = var.egresses

    content {
      description = "${egress.key}"
      from_port = lookup(egress.value, "from_port", 0)
      to_port = lookup(egress.value, "to_port", 0)
      protocol = lookup(egress.value, "protocol", "-1")
      cidr_blocks = lookup(egress.value, "cidr_blocks", ["0.0.0.0/0"])
    }
  }

  tags = {
    Name = var.security_group_name
  }
}
