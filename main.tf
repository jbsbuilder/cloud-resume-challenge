module "s3" {
  source           = "./modules/s3"
  bucket_name      = var.bucket_name
  root_bucket_name = var.root_bucket_name
}

module "cloudfront" {
  source         = "./modules/cloudFront"
  domain_name_cf = module.s3.website_endpoint
  bucket_name    = var.bucket_name
  root_domain_cf = module.s3.website_endpoint_root
}
