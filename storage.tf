data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.S3DB1.arn]
    }

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
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

