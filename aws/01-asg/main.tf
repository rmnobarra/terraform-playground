provider "aws" {
  region = "us-east-1"
}

data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-053b0d53c279acc90"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]
  key_name        = var.key_name
  user_data       = <<-EOF
	  #!/bin/bash
	  echo "Hello, World" > index.html
	  nohup busybox httpd -f -p ${var.server_port} > httpd.out 2> httpd.err &
  EOF

  user_data_replace_on_change = true

  subnet_id = var.subnet_id

  tags = {
    Name = "terraform-example"
  }
  lifecycle{
    create_before_destroy=true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier       = [aws_subnet.example1.id, aws_subnet.example2.id]
  min_size = 2
  max_size = 4

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}


resource "aws_security_group" "instance" {
  name   = "terraform-example-instance"
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]

  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]

  }
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "key_name" {
  type = string
}
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
