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
    "DB-1a" = {
        availability_zone = "ap-northeast-2a"
        map_public_ip_on_launch = false
        cidr_block = "10.0.4.0/24"
    },
    "DB-2c" = {
        availability_zone = "ap-northeast-2a"
        map_public_ip_on_launch = false
        cidr_block = "10.0.5.0/24"
    },
}