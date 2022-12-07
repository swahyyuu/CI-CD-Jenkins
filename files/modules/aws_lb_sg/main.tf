resource "aws_security_group" "sg_lb" {
  name        = "SG for Load Balancer"
  description = "Enable port 22, 80, 443 to accept request"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var.any_port
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.any_port
  }

  tags = {
    Name = "SG for Load Balancer"
  }
}

resource "aws_security_group" "sg_ec2" {
  name        = "SG for instances"
  description = "Enable port 22, 80, 443 to accept request"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var.any_port
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.any_port
  }

  tags = {
    Name = "SG for instances"
  }
}

resource "aws_elb" "classic_lb" {
  name = "classic-lb"
  security_groups = [
    "${aws_security_group.sg_lb.id}"
  ]
  subnets = [
    "${var.subnet_id_1}",
    "${var.subnet_id_2}",
    "${var.subnet_id_3}"
  ]

  cross_zone_load_balancing = true

  health_check {
    healthy_threshold    = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}
