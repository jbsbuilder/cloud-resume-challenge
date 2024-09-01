output "cloudfront_id" {
  value = aws_cloudfront_distribution.cloud-resume-challenge.domain_name
}

output "cloudfront_zone" {
  value = aws_cloudfront_distribution.cloud-resume-challenge.hosted_zone_id
}
