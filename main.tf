resource "aws_acm_certificate" "cert" {
  domain_name       = "sriharsha.cloudns.ch"
  validation_method = "DNS"

  tags = {
    Environment = "${var.env}-certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}
variable "env" {
  
}
resource "aws_route53_record" "main" {
  allow_overwrite = true
  name            = "${var.env}.certificate"
  records         = [aws_acm_certificate.cert.validation_method]
  ttl             = 60
  type            = "CNAME"
  zone_id         = data.aws_route53_zone.selected.zone_id
}