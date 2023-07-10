provider "aws" {
  region = var.region
}

# Terraform의 State를 저장 할 S3
resource "aws_s3_bucket" "mys3bucket" {
  bucket = "${var.nickname}-t101study-tfstate"
}

# State Versioning을 위하여 만들어진 S3를 Versioning 설정 추가
resource "aws_s3_bucket_versioning" "mys3bucket_versioning" {
  bucket = aws_s3_bucket.mys3bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# RDS 
resource "aws_dynamodb_table" "mydynamodbtable" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST" # 사용량에 따른 과금 모드
  hash_key     = "LockID" # DynamoDB 테이블에서 사용 될 해시 키의 이름

  attribute {
    name = "LockID" 
    type = "S" # LockID를 String으로 저장
  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.mys3bucket.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.mydynamodbtable.name
  description = "The name of the DynamoDB table"
}
