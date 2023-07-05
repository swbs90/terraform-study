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
      condition = (var.file_list[0] == var.file_name || var.file_list[1] == var.file_name ||
        var.file_list[2] == var.file_name || var.file_list[3] == var.file_name ||
      var.file_list[4] == var.file_name || var.file_list[5] == var.file_name || var.file_list[6] == var.file_name)
      error_message = "file name is not file_list"
    }
  }
}