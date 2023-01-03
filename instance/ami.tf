# amazon linux2 ami latest kernel-5
data "aws_ami" "amazon-linux-2-kernel-5" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5*"]
  }
}

output "ami_id" {
  value = data.aws_ami.amazon-linux-2-kernel-5.id
}