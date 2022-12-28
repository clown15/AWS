variable "vpc_name" {
    dedefault = "Onboarding-vpc  "
}

variable "vpc-cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnets" {
    type = map(object({
        availability_zone = string
        map_public_ip_on_launch = bool
        cidr_block = string
    }))
}

variable "private_subnets" {
    type = map(object({
        availability_zone = string
        map_public_ip_on_launch = bool
        cidr_block = string
    }))
}