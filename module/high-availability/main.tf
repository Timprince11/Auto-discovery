#Jenkins loadbalancer
resource "aws_lb" "PADUS1-alb" {
  name            = var.jenkins-lb-name
  load_balancer_type = "application"
  internal        = false
  security_groups = var.PADUS1-Jenkins-SG
  subnets         = var.pub-subnet-name
  enable_deletion_protection = false

  tags = {
    Name = var.jenkins-lb-name
  }
}

resource "aws_lb_listener" "PADUS1-alb-listener" {
  load_balancer_arn = aws_lb.PADUS1-alb.arn
  protocol          = "HTTP"
  port              = "80"

  default_action {
    target_group_arn = aws_lb_target_group.PADUS1-alb-target-group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "PADUS1-alb-target-group" {
  name     = var.jenkins-tg-name
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc-name
}

resource "aws_lb_target_group_attachment" "PADUS1-alb-target-group-attach" {
  target_group_arn = aws_lb_target_group.PADUS1-alb-target-group.arn
  target_id        = var.jenkins-server
  port             = 8080
}



# Staging Docker loadbalancer
resource "aws_lb" "PADUS1-asg" {
  name            = var.docker-lb-name
  load_balancer_type = "application"
  internal        = false
  security_groups = var.PADUS1-Docker-SG
  subnets         = var.pub-subnet-name
  enable_deletion_protection = false

  tags = {
    Name = var.docker-lb-name
  }
}


resource "aws_lb_listener" "PADUS1-asg-listener" {
  load_balancer_arn = aws_lb.PADUS1-asg.arn
  protocol          = "HTTP"
  port              = "80"

  default_action {
    target_group_arn = aws_lb_target_group.PADUS1-asg-target-group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "PADUS1-asg-target-group" {
  name     = var.docker-tg-lb
  port     = 8085
  protocol = "HTTP"
  vpc_id   = var.vpc-name
}


#Create Prod Docker loadbalancer
resource "aws_lb" "Prod-PADUS1-asg" {
  name            = var.prod-docker-lb-name
  load_balancer_type = "application"
  internal        = false
  security_groups = var.PADUS1-Docker-SG
  subnets         = var.pub-subnet-name
  enable_deletion_protection = false

  tags = {
    Name = var.prod-docker-lb-name
  }
}


resource "aws_lb_listener" "Prod-PADUS1-asg-listener" {
  load_balancer_arn = aws_lb.Prod-PADUS1-asg.arn
  protocol          = "HTTP"
  port              = "80"

  default_action {
    target_group_arn = aws_lb_target_group.Prod-PADUS1-asg-target-group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "Prod-PADUS1-asg-target-group" {
  name     = var.prod-docker-tg-lb
  port     = 8085
  protocol = "HTTP"
  vpc_id   = var.vpc-name
}