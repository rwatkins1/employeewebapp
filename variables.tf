variable aws_vpc {
    type = string
    default = "my_vpc"
}

variable "bucket_name" {
  type = string
  default = "my-bucket1231zz"
}

variable "ami" {
  default = "ami-06c68f701d8090592"
}

variable "instance_type"{
  default = "t2.micro"
}

variable "key_name" {
  default = "demo"
}

variable "aws_iam_role"{
  default = "S3DBRole"
}

variable "aws_iam_instance_profile" {
  default = "S3DBRole" 
  description = "The name of the IAM instance profile to use for EC2 instances"
  type        = string
}