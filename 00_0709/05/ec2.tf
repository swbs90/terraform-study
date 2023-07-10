# 미리 선언한 변수 리스트를 이용하여 dynamic block을 사용하여 ports값들을 sg값에 맵핑시키고 적용한다.
resource "aws_security_group" "ungec2" {
  vpc_id = aws_vpc.ung_vpc.id
  name   = "${var.prefix}-${var.server-prefix}"

  dynamic "ingress" {
    for_each = var.my_port.sg_tcp_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = var.my_port.sg_udp_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



#################################################################################################
# 미리 선언한 변수 값을 이용하여 instance_name key 값만큼 ec2를 생선한다. 
resource "aws_instance" "ung-server" {
  for_each                    = {for idx, ung_instance_name in var.ung_instance_name: ung_instance_name => idx}
  subnet_id                   = aws_subnet.public_subnet.id
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = var.key_pair
  associate_public_ip_address = true
  instance_type               = var.instance_spec
  vpc_security_group_ids = [
    aws_security_group.ungec2.id
  ]
  tags = {
    # ec2의 이름은 알아볼 수 있도록 key 값을 중간에 매칭시킨다.
    Name         = "${var.prefix}-${each.key}-${var.server-prefix}"
    ENV          = "DEV"
  }
}
#################################################################################################
### ubuntu ami search
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  } 

  owners = ["099720109477"] # Canonical
}