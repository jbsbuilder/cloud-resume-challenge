data "aws_route53_zone" "root_domain" {
  name         = "cloudsmithlabs.com"
  private_zone = false
}

resource "aws_route53_record" "cf_record" {
  zone_id = data.aws_route53_zone.root_domain.zone_id
  name    = "cloudresumechallenge.cloudsmithlabs.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

