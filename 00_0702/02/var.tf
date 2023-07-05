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
