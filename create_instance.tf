resource "aws_instance" "ec2" {
  ami                    = "ami-0eddbd81024d3fbdd"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = "aws-key"
  user_data              = <<-EOF
        #!/bin/bash
        yum install -y httpd
        systemctl enable --now httpd
        echo "Hello, Terraform" > /var/www/html/index.html
        EOF
  tags = {
    Name = "terraform-example-${count.index}"
  }
  count = 1
}

resource "aws_ami_from_instance" "web_server_ami" {
  name = "terraform_ami"
  source_instance_id = aws_instance.ec2.0.id

  depends_on = [
    aws_instance.ec2
  ]

  snapshot_without_reboot = false
}