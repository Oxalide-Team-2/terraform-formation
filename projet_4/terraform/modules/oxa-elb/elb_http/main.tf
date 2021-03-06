/*
 * Module: oxa-elb/elb_http
 */

resource "aws_elb" "elb" {
  name = "${var.elb_name}"

  security_groups = ["${var.elb_security_group}"]
  subnets         = ["${var.elb_subnet_ids}"]

  internal = "${var.elb_is_internal}"

  listener {
    lb_port           = "80"
    lb_protocol       = "http"
    instance_port     = "${var.backend_port}"
    instance_protocol = "${var.backend_protocol}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.health_check_target}"
    interval            = 30
  }

  cross_zone_load_balancing = true

  instances = [
    "${var.elb_instance_ids}",
  ]

  tags {
    Name               = "${var.elb_name}"
    oxaname            = "${var.elb_oxaname}"
    Description        = "ELB Proxy Protocol"
    ManagementTool     = "Terraform"
    ManagementModule   = "oxa-elb//elb_http"
    NotificationPeriod = "${var.notification_period}"
  }
}
