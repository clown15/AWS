ingresses = {
  "http" = {
    from_port = 80
    protocol = "tcp"
    to_port = 80
  },
  "ssh" = {
    from_port = 22
    protocol = "tcp"
    to_port = 22
  },
  "icmp" = {
    from_port = -1
    protocol = "icmp"
    to_port = -1
  },
}

egresses = {
  "out" = {
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
}
