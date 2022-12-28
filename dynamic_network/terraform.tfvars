public_subnets = {
    public-sub-a = {
        availability_zone = "ap-northeast-2a"
        map_public_ip_on_launch = true
        cidr_block = "10.0.0.0/24"
    }
    public-sub-b = {
        availability_zone = "ap-northeast-2b"
        map_public_ip_on_launch = true
        cidr_block = "10.0.1.0/24"
    }
    public-sub-c = {
        availability_zone = "ap-northeast-2c"
        map_public_ip_on_launch = true
        cidr_block = "10.0.2.0/24"
    }
    public-sub-d = {
        availability_zone = "ap-northeast-2d"
        map_public_ip_on_launch = true
        cidr_block = "10.0.3.0/24"
    }
}

private_subnets = {
    private-sub-a = {
        availability_zone = "ap-northeast-2a"
        map_public_ip_on_launch = false
        cidr_block = "10.0.10.0/24"
    }
    private-sub-b = {
        availability_zone = "ap-northeast-2b"
        map_public_ip_on_launch = false
        cidr_block = "10.0.11.0/24"
    }
    private-sub-c = {
        availability_zone = "ap-northeast-2c"
        map_public_ip_on_launch = false
        cidr_block = "10.0.12.0/24"
    }
    private-sub-d = {
        availability_zone = "ap-northeast-2d"
        map_public_ip_on_launch = false
        cidr_block = "10.0.13.0/24"
    }
}