/*
  Global
*/
variable "project" {
  type    = string
  default = "ung-int-220722"
}
variable "my_credentials" {
  type    = string
  default = "/Users/mzc01-ung/pem-dir/credentials.json"
}
variable "multi_region" {
  type    = string
  default = "ASIA"
}
variable "region" {
  type    = string
  default = "asia-northeast3"
}
variable "zone" {
  type    = string
  default = "asia-northeast3-a"
}
variable "project_id" {
  type    = string
  default = "unghee"  
}
/*
  Compute
*/
variable "prefix" {
  type    = string
  default = "my-mega"
}
variable "machine_type" {
  type    = string
  default = "f1-micro"
}
variable "boot_disk" {
  type    = string
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}
variable "ssh_user" {
  type    = string
  default = "centos"
}
variable "service_port" {
  type    = string
  default = "8090"
}

variable "bastion_instance_access_cidr" {
  type = string
  default = "0.0.0.0/0"
}

variable "web_instance_access_cidr" {
  type = string
  default = "10.128.0.0/9"
}


/*
  Database
*/

variable "database_type" {
  type    = string
  default = "db-f1-micro"
}

variable "database_version" {
  type    = string
  default = "POSTGRES_14"
}

variable "db_instance_access_cidr" {
  type = string
  default = "0.0.0.0/0"
}