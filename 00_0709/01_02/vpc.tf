
# 사용 가능한 az를 불러온다
data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_vpc" "ungvpc" {
  cidr_block       = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "t101-study"
  }
}

# 위에서 만든 VPC id를 참조하고 배포 할 az는 data block에 참조 받는다.
resource "aws_subnet" "ungsubnet1" {
  vpc_id     = aws_vpc.ungvpc.id
  cidr_block = "10.10.1.0/24"

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "ung-${data.aws_availability_zones.available.names[0]}"
    Type = "Terraform"
  }
}

# 위에서 만든 VPC id를 참조하고 배포 할 az는 data block에 참조 받는다.
resource "aws_subnet" "ungsubnet2" {
  vpc_id     = aws_vpc.ungvpc.id
  cidr_block = "10.10.2.0/24"

  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "ung-${data.aws_availability_zones.available.names[1]}"
    Type = "Terraform"
  }
}


