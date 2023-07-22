#AWS의 S3 버킷을 2개의 리전에서 동작하는 테라폼 코드를 작성해보세요!

provider "aws" {
  region = "ap-northeast-2"
  alias  = "prod-region"
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "dev-region"
}

resource "aws_s3_bucket" "prod_region" {
  provider = aws.prod-region

  bucket = "prod-region-ung"

}

resource "aws_s3_bucket" "dev_region" {
  provider = aws.dev-region

  bucket = "dev-region-ung"

}