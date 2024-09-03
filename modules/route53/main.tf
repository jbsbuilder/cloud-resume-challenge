data "aws_route53_zone" "root_domain" {
  name         = "cloudsmithlabs.com"
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.root_domain.zone_id
  name = "www.cloudresumechallenge.cloudsmithlabs.com"
  type = "A"

  alias {
    name = var.cloudfront_id
    zone_id = var.cloudfront_zone
    evaluate_target_health = false
  }
}
