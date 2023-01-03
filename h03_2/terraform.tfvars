public_subnets = {
    "public-1a" = {
        availability_zone = "ap-northeast-2a"
        map_public_ip_on_launch = true
        cidr_block = "10.0.0.0/24"
    },
    "public-2c" = {
        availability_zone = "ap-northeast-2c"
        map_public_ip_on_launch = true
        cidr_block = "10.0.1.0/24"
    },
    "public-3b" = {
        availability_zone = "ap-northeast-2b"
        map_public_ip_on_launch = true
        cidr_block = "10.0.10.0/24"
    },
    "public-4d" = {
        availability_zone = "ap-northeast-2b"
        map_public_ip_on_launch = true
        cidr_block = "10.0.11.0/24"
    },
}

private_subnets = {
    "private-1a" = {
        availability_zone = "ap-northeast-2a"
        map_public_ip_on_launch = false
        cidr_block = "10.0.2.0/24"
    },
    "private-2c" = {
        availability_zone = "ap-northeast-2c"
        map_public_ip_on_launch = false
        cidr_block = "10.0.3.0/24"
    }, 
}

private_subnets_db = {
  "DB-1a" = {
        availability_zone = "ap-northeast-2a"
        map_public_ip_on_launch = false
        cidr_block = "10.0.4.0/24"
    },
    "DB-2c" = {
        availability_zone = "ap-northeast-2c"
        map_public_ip_on_launch = false
        cidr_block = "10.0.5.0/24"
    },
}

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