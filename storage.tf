data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.S3DB1.arn]
    }

    actions = [
      "s3:*",
    ]

    resources = [
      aws_s3_bucket.my-bucket1231zz.arn,
      "${aws_s3_bucket.my-bucket1231zz.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my-bucket1231zz.id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "rennard-logging-bucket1"
}

