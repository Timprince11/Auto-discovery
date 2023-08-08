# AMI From Docker Snapshot
resource "aws_ami_from_instance" "PADUS1_host_ami" {
 name               = var.ami-name
 source_instance_id = var.target-instance
}

# creating launch confiuguration
resource "aws_launch_configuration" "PADUS1_LC" {
 name           = var.launch-configname
 instance_type   = var.instance-type
 image_id        = aws_ami_from_instance.PADUS1_host_ami.id
 security_groups = [var.sg_name]
 key_name        = var.key_name 
}

# Create docker asg
resource "aws_autoscaling_group" "ASG" {
name = var.asg-group-name
max_size = 4
min_size = 1
desired_capacity = 2
health_check_grace_period = 300
health_check_type = "EC2"
force_delete = true
launch_configuration = aws_launch_configuration.PADUS1_LC.name
vpc_zone_identifier  = var.vpc-zone-identifier
}

resource "aws_autoscaling_attachment" "asg_attach" {
autoscaling_group_name = aws_autoscaling_group.ASG.id
lb_target_group_arn = var.target-group-arn
}

resource "aws_autoscaling_policy" "host_ASG_POLICY" {
name  = var.asg-policy
scaling_adjustment = 1
adjustment_type = "ChangeInCapacity"
cooldown  = 60
autoscaling_group_name = aws_autoscaling_group.ASG.name
}


# Creating prod environment
resource "aws_autoscaling_group" "Prod-ASG" {
name = var.prod-asg-group-name
max_size = 4
min_size = 1
desired_capacity = 2
health_check_grace_period = 300
health_check_type = "EC2"
force_delete = true
launch_configuration = aws_launch_configuration.PADUS1_LC.name
vpc_zone_identifier  = var.vpc-zone-identifier
}

resource "aws_autoscaling_attachment" "prod_asg_attach" {
autoscaling_group_name = aws_autoscaling_group.Prod-ASG.id
lb_target_group_arn = var.prod-target-group-arn
}

resource "aws_autoscaling_policy" "prod-host_ASG_POLICY" {
name  = var.prod-asg-policy
scaling_adjustment = 1
adjustment_type = "ChangeInCapacity"
cooldown  = 60
autoscaling_group_name = aws_autoscaling_group.Prod-ASG.name
}