output "public_ip" {
  description = "This is Public IP of ec2 Instance"
  value = aws_instance.demo.public_ip
}

output "instance_id" {
  description = "This is Instance ID"
  value = aws_instance.demo.id
}