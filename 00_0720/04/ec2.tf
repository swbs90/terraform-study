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
# 첫번째 서버
resource "aws_instance" "ung-server" {
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
    Name         = "${var.prefix}-web-${var.server-prefix}"
    ENV          = "DEV"
  }  
}

#################################################################################################
# 두번째 서버
resource "aws_instance" "yu-server" {
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
    Name         = "${var.prefix}-was-${var.server-prefix}"
    ENV          = "DEV"
  }  
}

resource "terraform_data" "bootstrap" {
  triggers_replace = [
    aws_instance.ung-server.id,
    aws_instance.yu-server.id
  ]

  provisioner "local-exec" {
    command = "echo ung-server-id:${aws_instance.ung-server.id},yu-server-id: ${aws_instance.yu-server.id}"
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