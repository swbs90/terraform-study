################################################################################################
# AWS Security Group
resource "aws_security_group" "httpd_sg" {
  name        = "${var.prefix}-httpd"
  description = "${var.prefix}-httpd"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}


#################################################################################################
### ec2 
resource "aws_instance" "httpd_ec2" {
  subnet_id                   = aws_subnet.public_subnet.id
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = var.key_pair
  associate_public_ip_address = true
  instance_type               = var.instance_spec
  vpc_security_group_ids = [
    aws_security_group.httpd_sg.id
  ]
  tags = {
    Name = "${var.prefix}-httpd-ec2"
  }
  user_data = templatefile("./template/install.tpl",
  {
      nickname = lookup(var.study_group,var.nickname,"another_team")
  })

  lifecycle {
    ignore_changes = [
      user_data
    ]
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