variable "vpc_name" {
    default = "Onboarding-vpc  "
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

variable "private_subnets_db" {
    type = map(object({
        availability_zone = string
        map_public_ip_on_launch = bool
        cidr_block = string
    }))
}

variable "security_group_name" {
  default = "Onboarding-SG"
  description = "security group name"
}

variable "ingresses" {
  type = map(object({
    from_port = number
    to_port = number
    protocol = string
  }))
}

variable "egresses" {
  type = map(object({
    from_port = number
    to_port = number
    protocol = string
  }))
}