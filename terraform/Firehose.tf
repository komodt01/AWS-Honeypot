variable "splunk_hec_endpoint" {
  description = "Your Splunk HEC endpoint (e.g., https://splunk.example.com:8088)"
  type        = string
}

variable "splunk_hec_token" {
  description = "Your Splunk HEC authentication token"
  type        = string
  sensitive   = true
}

resource "aws_kinesis_firehose_delivery_stream" "to_splunk" {
  name        = "honeypot-firehose"
  destination = "splunk"

  splunk_configuration {
    hec_endpoint               = var.splunk_hec_endpoint
    hec_token                  = var.splunk_hec_token
    hec_acknowledgment_timeout = 180
    retry_duration             = 300
    s3_backup_mode             = "FailedEventsOnly"
    s3_configuration {
      role_arn           = aws_iam_role.firehose_role.arn
      bucket_arn         = aws_s3_bucket.firehose_backup.arn
      buffering_interval = 300
      buffering_size     = 5
      compression_format = "GZIP"
    }
  }

  tags = {
    Name = "honeypot-to-splunk"
  }
}

resource "aws_s3_bucket" "firehose_backup" {
  bucket = "honeypot-firehose-backup-${random_id.bucket_id.hex}"
  force_destroy = true
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_iam_role" "firehose_role" {
  name = "firehose-to-splunk-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "firehose.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "firehose_policy" {
  name = "firehose-splunk-policy"
  role = aws_iam_role.firehose_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:AbortMultipartUpload",
          "s3:PutObjectAcl"
        ],
        Resource = [
          "${aws_s3_bucket.firehose_backup.arn}/*",
          "${aws_s3_bucket.firehose_backup.arn}"
        ]
      }
    ]
  })
}
