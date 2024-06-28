resource "aws_iam_role" "S3DB1" {
  name               = "S3DB1"
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

resource "aws_iam_instance_profile" "S3DB1" {
  name = "S3DB1"
  role = aws_iam_role.S3DB1.name
}

# Attach the AmazonDynamoDBFullAccess policy
resource "aws_iam_role_policy_attachment" "dynamodb_full_access" {
  role       = aws_iam_role.S3DB1.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

# Attach the AmazonS3FullAccess policy
resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.S3DB1.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
