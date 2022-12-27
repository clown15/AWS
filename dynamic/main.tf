resource "aws_vpc" "hands_on_vpc" {
  cidr_block = "10.0.0.0/16"
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
