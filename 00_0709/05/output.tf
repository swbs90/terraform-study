# output의 for문을 이용하여 생성되는 리소스의 결과값을 반복문으로 호출한다.
output "ung-server" {
  value = [
    for k, v in aws_instance.ung-server :
    "${v.public_ip}"
  ]
}
