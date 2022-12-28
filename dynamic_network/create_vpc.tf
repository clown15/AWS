resource "aws_vpc" "Onboarding-vpc" {
    cidr_block = var.vpc-cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"

    tags = {
        Name = "${var.vpc_name}"
    }
}

# 퍼블릭 서브넷
resource "aws_subnet" "Onboarding-subnet" {
    vpc_id = aws_vpc.Onboarding-vpc.id

    dynamic "subnets" {
        for_each = var.public_subnets
        iterator = "pub"

        content {
            availability_zone = pub.value["availability_zone"]
            cidr_block = pub.value["cidr_block"]
            map_public_ip_on_launch = pub.value["map_public_ip_on_launch"]

            tags = {
                Name = "${pub.key}"
            }
        }
    }
}

# 프라이빗 서브넷
resource "aws_subnet" "Onboarding-subnet-pri" {
    vpc_id = aws_vpc.Onboarding-vpc.id

    dynamic "subnets" {
      for_each = var.private_subnets

      availability_zone = subnets.value["availability_zone"]
      cidr_block = subnets.value["cidr_block"]
      map_public_ip_on_launch = subnets.value["map_public_ip_on_launch"]

      tags = {
        Name = "${subnets.key}"
      }
    }
}

# 인터넷 게이트 웨이 생성
resource "aws_internet_gateway" "Onboarding-igw" {
    vpc_id = aws_vpc.Onboarding-vpc.id

    tags = {
        Name = "Onboarding-igw"
    }
}

# 기본 라우팅 테이블 경로 설정
# resource "aws_route" "Onboarding-vpc-igw-access" {
#     route_table_id = aws_vpc.Onboarding-vpc.main_route_table_id
#     destination_cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.Onboarding-igw.id
# }

# 퍼블릭 라우팅 테이블 생성
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.Onboarding-vpc.id

    tags = {
        Name = "public route table"
    }
}

# 생성한 퍼블릭 라우팅 테이블에서 경로 설정(IGW)
resource "aws_route" "public-igw-access" {
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Onboarding-igw.id
}

# 라우팅 테이블에 서브넷 명시적 연결
resource "aws_route_table_association" "public_subnets" {
    for_each = aws_subnet.Onboarding-subnet
    subnet_id = each.value.id
    # route_table_id = aws_vpc.Onboarding-vpc.main_route_table_id
    route_table_id = aws_route_table.public_route_table.id
}