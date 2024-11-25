variable "region" {
  description = "AWS Region"
  default = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID"
  default = "ami-0166fe664262f664c"
}

variable "instance_type" {
  description = "This is Instance Type"
  default = "t2.micro"
}

variable "public_key_path" {
  description = "This is Path for Public Key"
  default =   "~/.ssh/id_rsa.pub"
  }


variable "private_key_path" {
  description = "This is Path for Private Key"
  default =   "~/.ssh/id_rsa"
  }