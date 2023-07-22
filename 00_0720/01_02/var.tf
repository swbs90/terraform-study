variable "prefix" {
  description = "resource 앞에 붙는 접두사"
  default     = "ung"
}
variable "region" {
  description = "nomad server region"
  default     = "ap-northeast-2"
}

variable "instance_spec" {
  description = "nomad server spec"
  default     = "t3.large"
}

variable "key_pair" {
  description = "nomad server ssh key pair"
  default     = "my_aws_key"
}

variable "nickname" {
  description = "my nick name"
  default     = "gasida-ung"
}
variable "ung_instance_name" {
  description = "ec2 name"
  type    = list(string)
  default = ["server-01", "server-02", "server-03"]
}

variable "my_port" {
  description = "TCP, UDP port range"
  default = {
    sg_tcp_ports = [22, 80, 443, 8800, 7990, 7999, 4646, 4647, 4648],
    sg_udp_ports = [4646, 4647, 4648]
  }
}

variable "server-prefix" {
  description = "resource 생성 시 붙는 접두사"
  default = "dev"
}

variable "create_ec2" {
  type        = string
  default     = "1"
  description = "1 or 0, 1이면 ec2 생성"
}
