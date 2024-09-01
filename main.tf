module "tfstate" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  acl = "private"
}

module "cloudfront" {
  source = "./modules/cloudfront"

  domain_name = module.static_bucket.domain_name
  acm_certificate_arn = module.acm_cert.acm_certificate_arn
}

 module "route53" {
  source = "./modules/route53"

  cloudfront_id = module.cloudfront.cloudfront_id
  cloudfront_zone = module.cloudfront.cloudfront_zone
}
