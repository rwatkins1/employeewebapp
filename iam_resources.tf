resource "aws_iam_role" "iam-role" {
  name               = var.aws_iam_role
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = var.aws_iam_role
  role = aws_iam_role.iam-role.name
}

# Attach the AmazonDynamoDBFullAccess policy
resource "aws_iam_role_policy_attachment" "dynamodb_full_access" {
  role       = aws_iam_role.iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

# Attach the AmazonS3FullAccess policy
resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
