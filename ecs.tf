resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.ecs_cluster_name}"
}

resource "aws_ecs_task_definition" "test_http" {
  family                = "test_http"
  container_definitions = "${file("tasks/test_http.json")}"
}

resource "aws_ecs_service" "test_http" {
  name            = "test_http"
  cluster         = "${aws_ecs_cluster.ecs-cluster.id}"
  desired_count   = 2
  task_definition = "${aws_ecs_task_definition.test_http.id}"
  depends_on      = ["aws_iam_role_policy.ecs_service_role_policy"]
}

resource "aws_autoscaling_group" "ecs-cluster" {
  availability_zones   = ["${lookup(var.availability_zone,"primary")}"]
  name                 = "ECS ${var.ecs_cluster_name}"
  min_size             = "${lookup(var.autoscale, "min")}"
  max_size             = "${lookup(var.autoscale, "max")}"
  desired_capacity     = "${lookup(var.autoscale, "desired")}"
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  vpc_zone_identifier  = ["${aws_subnet.public-One.id}"]
}

resource "aws_launch_configuration" "ecs" {
  name                 = "ECS ${var.ecs_cluster_name}"
  image_id             = "${lookup(var.amazon_amis, var.region)}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${aws_security_group.default.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

  key_name                    = "${aws_key_pair.terraform.key_name}"
  associate_public_ip_address = true
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}' > /etc/ecs/ecs.config"
}
