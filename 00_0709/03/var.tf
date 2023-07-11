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

# default값을 비워두고 변수 값은 테라폼으로 배포 시 받아오게 한다.
variable "nickname" {
  description = "my nick name"
}

# nickname을 체크하고 그에 맞는 반환 값을 미리 정해둔다.
variable "study_group" {
  description = "my study group members"
  default     = {
    "ung": "member1", 
    "yu" : "member2", 
    "chang": "member3",
    "jun"  : "member4"
  }
}