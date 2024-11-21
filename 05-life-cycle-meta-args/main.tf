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
  ami               = "ami-012967cc5a8c9f891"
  instance_type     = "t2.micro"
#   availability_zone = "us-east-1b"
# lifecycle {
#   create_before_destroy = true
# }
# lifecycle {
#   prevent_destroy = true
# }
lifecycle {
  ignore_changes = [ tags, ]
}

  tags = {
    Name = "WebServer"
    Dept = "IT"
   
  }
}