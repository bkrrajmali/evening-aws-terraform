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

resource "aws_instance" "myec2" {
  ami = var.ec2_ami_id
  instance_type = var.instance_type
  tags = {
    Name = "Demoec2-for-Inputvariables"
  }
}