terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }
  backend "s3" {
    bucket = "terraformawsbackendconf"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

variable "ami_id" {}
variable "instance_type" {}
variable "Name" {}
variable "env" {}

resource "aws_instance" "myec2" {
  instance_type = var.instance_type
  ami = var.ami_id
  tags = {
    Name = var.Name
    env = var.env
  }
}


resource "aws_s3" "name" {
  
}

resource "aws_dynamodb_table" "name" {
  
}


resource "aws_lambda_function" "name" {
  
}



s3  ---prod dev

dynamodb_table--prod  test

lambda  prod 