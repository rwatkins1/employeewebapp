variable aws_vpc {
    type = string
    default = "my_vpc"
}

variable "bucket_name" {
  type = string
  default = "my-bucket1231zz"
}

variable "ami" {
  default = "08a0d1e16fc3f61ea"
}

variable "instance_type"{
  default = "t2.micro"
}

variable "key_name" {
  default = "demo"
}