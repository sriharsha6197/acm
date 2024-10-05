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
output "validation_records" {
  value = aws_acm_certificate.cert.domain_validation_options
}
resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.selected.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.value]
}