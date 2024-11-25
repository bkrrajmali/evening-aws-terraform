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

resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.demo.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo.id
}

resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id
}

resource "aws_route" "demo" {
  route_table_id = aws_route_table.demo.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.demo-igw.id
}

resource "aws_route_table_association" "demo-rt" {
  route_table_id = aws_route_table.demo.id
  subnet_id = aws_subnet.public.id
}

resource "aws_security_group" "demo-sg" {
  vpc_id = aws_vpc.demo.id
  name = "Allow_All"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "demo-key" {
  key_name = "terraform-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "demo" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = aws_key_pair.demo-key.key_name
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [ aws_security_group.demo-sg.id ]
  
  provisioner "local-exec" {
    command = "echo 'Ec2 Instance with public IP ${self.public_ip} is up and running' > instance_info.txt"
  }
 }

 resource "null_resource" "copy_file" {
   provisioner "file" {
     source = "install_apache.sh"
     destination = "/tmp/install_apache.sh"
     connection {
       type = "ssh"
       user = "ec2-user"
       host = aws_instance.demo.public_ip
       private_key = file(var.private_key_path)
     }
   }
   
   provisioner "remote-exec" {
     connection {
       type = "ssh"
       user = "ec2-user"
       host = aws_instance.demo.public_ip
       private_key = file(var.private_key_path)
     }
     inline = [ "bash /tmp/install_apache.sh" ]
   }
   depends_on = [ aws_instance.demo ]
 }