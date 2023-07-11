# Terraform: Study 2주차

## Repo 구조

```bash
# 2주차 도전과제 
├── 01_02  #리전 내에서 사용 가능한 가용영역 목록 가져오기를 사용한 VPC 리소스 생성 실습 진행
          # 리소스의 이름(myvpc, mysubnet1 등)을 반드시! 꼭! 자신의 닉네임으로 변경
├── 03 # 입력변수를 활용해서 리소스(어떤 리소스든지 상관없음)를 배포해보고, 해당 코드를 정리해주세요!
├── 04
└── 05
```

1. 01_02 EC2 웹 서버 배포 + 리소스 생성 그래프 확인
- vpc.tf
   -  Resource 이름들의 닉네임을 기재, 가용영역 목록을 가져오고 그 가용영역 목록으로 VPC 리소스 생성
### code 리뷰   
- data block에서 aws의 aws_availability_zones 리소스를 정의하고 상태 값이 "available"한 값을 불러옴
- "aws_vpc" resource block에서 리소스명을 ungvpc로 정의하였고 각각의 "aws_subnet" resource block에서 vpc_id를 참조를 받기 위해   ungvpc에서 resource id값을 참조 받아옴
- "aws_subnet"들에서는 배치하는 az는 미리 선언한 "available" resource blcok의 값을 참조 받아옴


3. 입력변수를 활용해서 리소스(어떤 리소스든지 상관없음)를 배포해보고, 해당 코드를 정리해주세요!
- 기존에 1주차에서 사용하였던 source를 활용 (https://github.com/swbs90/terraform-study/tree/main/00_0702/01)
- var.tf
  - default값을 비워두고 변수 값은 테라폼으로 배포 시 받아오게 한다.
- 실행
```bash
$ terraform apply -auto-approve  
# 변수 nickname의 값을 terraform 실행 시 입력을 받는다.
var.nickname
  my nick name

  Enter a value: my_second_class 
```

- 결과
  - 블로그에 추가

4. local를 활용해서 리소스(어떤 리소스든지 상관없음)를 배포해보고, 해당 코드를 정리해주세요!
- local를 이용하여 자주 사용하고 정형화된 tag값을 관리하기
- vpc.tf
   -  locals의 tag 값을 list 형식으로 관리
   -  각 tag값을 받아 올 리소스에서는 local 변수를 호출
      - ex) local.dev_env_tags #local.선언한 변수
- 결과
  - 블로그에 추가


5. count, for_each 반복문, for문, dynamic문 을 활용해서 리소스(어떤 리소스든지 상관없음)를 배포해보고, 해당 코드를 정리해주세요!
- var.tf
   -  dynamic block과 for_each를 사용하기 위해 list 변수를 두개(instance name, port group) 선언
- ec2.tf
   - security_group
     -  dynamic block을 이용하여 "my_port" 변수에서 값을 하나씩 빼면서 tcp, udp ingress를 완성
   - aws_instance
     -  for_each를 이용하여 instance_name의 값을 하나씩 빼면서 갯수만큼 ec2를 배포
- output.tf
   - 만들어지는 ec2의 갯수만큼 for 루프가 돌면서 각 ec2의 public ip를 출력

- terraform 실행결과
```bash
...


```
