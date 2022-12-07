resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_sensitive_file" "private_key" {
  filename        = "${var.key_name}.pem"
  content         = tls_private_key.key.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "public_key" {
  key_name   = "terraform-test"
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_launch_template" "template" {
  name = "ec2_instance_template"

  block_device_mappings {
    device_name = "/dev/sdx"

    ebs {
      volume_size           = 12
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = false

  instance_type = var.instance_type
  image_id      = data.aws_ami.ubuntu.id
  key_name      = var.key_name

  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    description                 = "network interface for ec2 launch template"
    security_groups             = ["${var.sg_ec2}"]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "instance template"
    }
  }

  user_data = base64encode(data.template_file.init.rendered)
}

resource "aws_autoscaling_group" "as_group" {
  name                      = "terraform-asg-example"
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 30
  health_check_type         = "ELB"
  force_delete              = true
  termination_policies      = ["OldestInstance"]

  load_balancers = [
    "${var.elb_id}"
  ]
  vpc_zone_identifier = [
    var.subnet_id_1,
    var.subnet_id_2,
    var.subnet_id_3
  ]

  enabled_metrics = [ 
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
    ]
  
  metrics_granularity = "1Minute"

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "AG with launch template"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_schedule" "schedule_up" {
  scheduled_action_name  = "autoscalegroup_action_up"
  min_size               = 1
  max_size               = 2
  desired_capacity       = 1
  time_zone              = "Asia/Jakarta"
  recurrence             = "00 21 * * 1-5"
  autoscaling_group_name = aws_autoscaling_group.as_group.name
}

resource "aws_autoscaling_schedule" "schedule_down" {
  scheduled_action_name  = "autoscalegroup_action_down"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  time_zone              = "Asia/Jakarta"
  recurrence             = "15 21 * * 1-5"
  autoscaling_group_name = aws_autoscaling_group.as_group.name
}

resource "aws_autoscaling_policy" "as_group_policy" {
  name                   = "autoscalegroup_policy"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.as_group.name
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_up" {
  alarm_name          = "ec2_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"
  alarm_actions = [
    "${aws_autoscaling_policy.as_group_policy.arn}"
  ]

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.as_group.name}"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["${var.account_id}"]

  filter {
    name   = "name"
    values = ["ubuntu-instance"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "template_file" "init" {
  template = file("${path.root}/${var.bash_dir}/check_services.sh")
  vars = {
    dockerhub_user = "${var.dockerhub_user}"
  }
}
