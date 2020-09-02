resource "aws_lb" "lab_tf_lb" {
  name               = "lab-tf-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.lab_loadbal_sg.id}"]
  subnets            = ["${aws_subnet.lab_subnet1.id}","${aws_subnet.lab_subnet2.id}"]

  tags = {
    Environment = "lab"
  }
}

resource "aws_lb_target_group" "lab_tf_tg" {
  name     = "lab-tf-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.lab_vpc.id}"
}

resource "aws_lb_listener" "lab_tf_listener" {
  load_balancer_arn = "${aws_lb.lab_tf_lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lab_tf_tg.arn}"
  }
}

resource "aws_lb_target_group_attachment" "lab_tf_tg_att_1" {
  target_group_arn = "${aws_lb_target_group.lab_tf_tg.arn}"
  target_id        = "${aws_instance.lab_ec1.id}"
  port             = 8080
}

resource "aws_lb_target_group_attachment" "lab_tf_tg_att_2" {
  target_group_arn = "${aws_lb_target_group.lab_tf_tg.arn}"
  target_id        = "${aws_instance.lab_ec2.id}"
  port             = 8080
}