resource "aws_route53_zone" "hosted_zone" {
  name = var.domain-name
}
resource "aws_route53_record" "nameservers" {
  allow_overwrite = true
  name            = var.domain-name
  ttl             = 3600
  type            = "NS"
  zone_id         = aws_route53_zone.hosted_zone.zone_id
  records = aws_route53_zone.hosted_zone.name_servers
}
resource "aws_route53_record" "terraform-test" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = var.sub-domain-name
  type    = "A"
  alias {
      name                   = aws_lb.lb.dns_name
      zone_id                = aws_lb.lb.zone_id
      evaluate_target_health = true
  }
}
