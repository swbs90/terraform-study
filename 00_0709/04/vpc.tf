#공통으로 사용 할 태그를 미리 locals 변수에 작성
locals {
  dev_env_tags = {
    Team = "DevOps"
    Env  = "DEV"
    Type = "Terraform"
  }
}

provider "aws" {
  region  = "ap-northeast-2"
}

resource "aws_vpc" "ungvpc" {
  cidr_block       = "10.10.0.0/16"
  #각 리소스마다 local 변수를 호출하여 태그를 관리
  tags = local.dev_env_tags
}