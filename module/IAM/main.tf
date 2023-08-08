# IAM_Instance_Profile
resource "aws_iam_instance_profile" "capeu2-IAM-Profile" {
  name = var.profilename
  role = aws_iam_role.capeu2_role.name
}

#IAM role
resource "aws_iam_role" "capeu2_role" {
  name = var.rolename

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = var.rolename
  }
}


#IAM Policy 

resource "aws_iam_policy" "capeu2_policy" {
  name        = var.policy
  description = "Allows all"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "capeu2_rolepolicy" {
  role       = aws_iam_role.capeu2_role.name
  policy_arn = aws_iam_policy.capeu2_policy.arn
}