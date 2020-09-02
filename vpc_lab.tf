# Create a VPC to launch our instances into
resource "aws_vpc" "lab_vpc" {
  cidr_block = "11.0.0.0/16"
  tags = {
      Name = "lab_vpc_2"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "lab_igw" {
  vpc_id = "${aws_vpc.lab_vpc.id}"

  tags = {
    Name = "lab_igw"
  }
}

# Create a subnet to launch our instances into
resource "aws_subnet" "lab_subnet1" {
  vpc_id = "${aws_vpc.lab_vpc.id}"
  cidr_block = "11.0.1.0/24"

  tags = {
    Name = "lab_subnet_1"
  }
}

# Create a subnet to launch our instances into
resource "aws_subnet" "lab_subnet2" {
  vpc_id = "${aws_vpc.lab_vpc.id}"
  cidr_block = "11.0.2.0/24"

  tags = {
    Name = "lab_subnet_2"
  }
}

resource "aws_route_table" "lab_route_table" {
  vpc_id = "${aws_vpc.lab_vpc.id}"

  tags = {
    Name = "lab_route_table"
  }
}

resource "aws_route_table_association" "lab_route_assoc_1" {
  subnet_id      = "${aws_subnet.lab_subnet1.id}"
  route_table_id = "${aws_route_table.lab_route_table.id}"
}

resource "aws_route_table_association" "lab_route_assoc_2" {
  subnet_id      = "${aws_subnet.lab_subnet2.id}"
  route_table_id = "${aws_route_table.lab_route_table.id}"
}

resource "aws_route" "lab_route" {
  route_table_id = "${aws_route_table.lab_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.lab_igw.id}"
}

