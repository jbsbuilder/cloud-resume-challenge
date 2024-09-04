output "domain_name" {
  value = aws_s3_bucket.cloud_resume_challenge.bucket_regional_domain_name
}

ouput "s3_static_bucket_id" {
  value = aws_s3_bucket.cloud_resume_challenge.id
}
