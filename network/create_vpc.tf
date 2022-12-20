resource "aws_vpc" "Onboarding-vpc" {
    cidr_block = var.vpc-cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"

    tags = {
        Name = "Onboarding-vpc"
    }
}

# 기본 라우팅 테이블을 생성하는 것이 아닌 기본 라우팅 테이블에 태그를 다는 코드로 기본 라우팅 테이블은 자동으로 생성 된다.
# resource "aws_default_route_table" "Onboarding-vpc" {
#     default_route_table_id = "${aws_vpc.Onboarding-vpc.default_route_table_id}"

#     tags = {
#         Name = "default"
#     }
# }

# 가용영역 가져오기
data "aws_availability_zones" "available" {
  state = "available"
}

output "available" {
    value = "${data.aws_availability_zones.available.names}"
}

# 퍼블릭 서브넷
resource "aws_subnet" "Onboarding-subnet" {
    for_each = var.public_subnets

    vpc_id = aws_vpc.Onboarding-vpc.id
    availability_zone = each.value.availability_zone
    cidr_block = each.value.cidr_block
    map_public_ip_on_launch = each.value.map_public_ip_on_launch

    tags = {
        Name = "${each.key}"
    }
}

# 프라이빗 서브넷
resource "aws_subnet" "Onboarding-subnet-pri" {
    for_each = var.private_subnets

    vpc_id = aws_vpc.Onboarding-vpc.id
    availability_zone = each.value.availability_zone
    cidr_block = each.value.cidr_block
    map_public_ip_on_launch = each.value.map_public_ip_on_launch

    tags = {
        Name = "${each.key}"
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

# 프라이빗 서브넷을 위한 라우팅 테이블 생성
# resource "aws_route_table" "private_route_table" {
#     vpc_id = aws_vpc.Onboarding-vpc.id

#     tags = {
#         Name = "private route table"
#     }
# }

# NAT를 위한 EIP 생성
resource "aws_eip" "private_eip" {
    vpc = true

    lifecycle {
        create_before_destroy = true
    }
}

# NAT생성
resource "aws_nat_gateway" "private" {
    allocation_id = aws_eip.private_eip.id
    subnet_id = aws_subnet.Onboarding-subnet["public-sub-a"].id

    depends_on = [ aws_route.public-igw-access, aws_eip.private_eip ]
}

# private routing table에 nat규칙 생성
resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.Onboarding-vpc.id

    tags = {
        Name = "private route table"
    }
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.private.id
    }
}

# 프라이빗 라우팅 테이블에 서브넷 명시적 연결
resource "aws_route_table_association" "private_subnets" {
    for_each = aws_subnet.Onboarding-subnet-pri

    subnet_id = each.value.id
    route_table_id = aws_route_table.private_route_table.id
}