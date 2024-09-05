output "domain_name" {
  value = aws_s3_bucket.cloud_resume_challenge.bucket_regional_domain_name
}

output "bucket_id" {
  value = aws_s3_bucket.cloud_resume_challenge.id
}

