variable "file_list" {
  type    = list(string)
  default = ["step0.txt", "step1.txt", "step2.txt", "step3.txt", "step4.txt", "step5.txt", "step6.txt"]
}

variable "file_name" {
  type    = string
  default = "step6.txt"
}

resource "local_file" "abc" {
  content  = "success!!!"
  filename = "${path.module}/success.txt"

  lifecycle {
    precondition {
      condition     = contains(var.file_list, var.file_name)
      error_message = "file name is not file_list"
    }
  }
}