resource "aws_elb" "elb" {
  name            = "elb"
  security_groups = ["${aws_security_group.default.id}"]
  subnets         = ["${aws_subnet.public-One.id}"]

  listener {
    lb_protocol       = "http"
    lb_port           = 80
    instance_protocol = "http"
    instance_port     = 80
  }

  cross_zone_load_balancing = true
}
