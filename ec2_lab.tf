data "template_file" "ec2_user_data" {
  #https://stackoverflow.com/questions/45584634/add-userdata-for-aws-instance-using-data-source-in-terraform
  template = "${file("${path.module}/user_data_tomcat.sh")}"
}

resource "aws_instance" "lab_ec1" {
  ami = "ami-09d95fab7fff3776c"
  instance_type = "t2.micro"
  key_name = "lab_keypair_1"
  #key_name = "${aws_key_pair.lab_key_pair.name}"
  subnet_id = "${aws_subnet.lab_subnet1.id}"
  vpc_security_group_ids = [
      "${aws_security_group.lab_bastion_sg.id}",
  ]
  associate_public_ip_address = true
  user_data = "${data.template_file.ec2_user_data.rendered}"
  #user_data = "${data.template_file.ec2_user_data.template}"
  #user_data = "${file("user_data_tomcat.sh")}"

  tags = {
    Name = "lab_ec1"
  }
}

resource "aws_instance" "lab_ec2" {
  ami = "ami-09d95fab7fff3776c"
  instance_type = "t2.micro"
  key_name = "lab_keypair_1"
  #key_name = "${aws_key_pair.lab_key_pair.name}"
  subnet_id = "${aws_subnet.lab_subnet2.id}"
  vpc_security_group_ids = [
      "${aws_security_group.lab_bastion_sg.id}",
  ]
  associate_public_ip_address = true
  user_data = "${data.template_file.ec2_user_data.rendered}"
  #user_data = "${data.template_file.ec2_user_data.template}"
  #user_data = "${file("user_data_tomcat.sh")}"

  tags = {
    Name = "lab_ec2"
  }
}