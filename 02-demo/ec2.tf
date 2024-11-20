resource "aws_instance" "myec2" {
  ami           = "ami-0166fe664262f664c"
  instance_type = "t2.micro"
  tags = {
    env = "Prod"
    Name = "MyEc2Instance"
  }
}