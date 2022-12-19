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
    Name = "terraform-example"
  }

  root_block_device {
    volume_size = "10"
    tags = {
        Name = "Terraform block"
    }
  }
}

data "aws_instance" "ec2" {
    filter {
      name = "tag:Name"
      values = ["terraform-example"]
    }
    filter {
      name = "instance-state-name"
      values = ["running"]
    }
}

locals {
    mount_point = data.aws_instance.ec2.root_block_device.*.device_name
}

output "test" {
  value = local.mount_point.0
}

resource "null_resource" "expand_disk" {
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("~/.ssh/aws-key.pem")
    host = data.aws_instance.ec2.public_ip
  }

  provisioner "remote-exec" {
    inline = [
        "sudo lsblk",
        "sudo growpart ${local.mount_point.0} 1",
        "sudo xfs_growfs -d /"
        # "sudo xfs_growfs ${local.mount_point.0}1",
    ]
  }
}