# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" 
    tags = {
    Name = "my_vpc"
  }
}

#Create a subnet
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  depends_on = [aws_vpc.my_vpc]  
  availability_zone = "us-east-1a"
    tags = {
    Name = "Public"
  }
}

#Create a subnet
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  depends_on = [aws_vpc.my_vpc]
  availability_zone = "us-east-1a"
}

#Create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
    tags = {
    Name = "main"
  }
}

resource "aws_route_table" "myRT" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
  Name = "myRT"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "route_table_assoc" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.myRT.id
}

#create a s3 bucket

resource "aws_s3_bucket" "my-bucket1231zz" {
  bucket = var.bucket_name
  force_destroy = true
}

#create security group

resource "aws_security_group" "TF_SG" {
  name_prefix= "TF-SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "TF_SG"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.TF_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.TF_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.TF_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.TF_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#create ec2 instance

resource "aws_instance" "amazonlinux" {
  ami           = "ami-08a0d1e16fc3f61ea"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  associate_public_ip_address = true
  subnet_id  = aws_subnet.subnet1.id
  key_name = "demo"
  iam_instance_profile = aws_iam_instance_profile.S3DB1.name

  depends_on = [
    aws_security_group.TF_SG
  ]
  availability_zone = "us-east-1a"
  user_data = <<EOT
#!/bin/bash -ex
wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/DEV-AWS-MO-GCNv2/FlaskApp.zip
unzip FlaskApp.zip
cd FlaskApp/
yum -y install python3-pip
pip install -r requirements.txt
export PHOTOS_BUCKET=my-bucket1231zz
export AWS_DEFAULT_REGION=us-east-1
export DYNAMO_MODE=on
FLASK_APP=application.py /usr/local/bin/flask run --host=0.0.0.0 --port=80 
EOT  

  tags = {
    Name = "Web-Server"
  }
}