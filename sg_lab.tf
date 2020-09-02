resource "aws_security_group" "lab_bastion_sg" {
  vpc_id = "${aws_vpc.lab_vpc.id}"
  #group_name = "BastionSG"
  description = "BastionSG"
  
  # HTTP access from anywhere
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # HTTP access from anywhere
  ingress {
    from_port = "8080"
    to_port = "8080"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # added as terraform removes ports by default
  # https://www.terraform.io/docs/providers/aws/r/security_group.html#from_port
  egress {
	from_port   = 0
	to_port     = 0
	protocol    = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "BastionSG"
  }
}

resource "aws_security_group" "lab_loadbal_sg" {
  vpc_id = "${aws_vpc.lab_vpc.id}"
  #group_name = "LoadBalSG"
  description = "LoadBalSG"

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # added as terraform removes ports by default  
  egress {
	from_port   = 0
	to_port     = 0
	protocol    = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "LoadBalSG"
  }
}