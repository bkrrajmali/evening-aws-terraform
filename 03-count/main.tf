terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-012967cc5a8c9f891"
  instance_type = "t2.micro"
  tags = {
    Name = "web-0${count.index}"
    //web-00
    //web-01
  }
}

/* if count is 2---count.index--0
               1-----------0
               2-----------1
               */