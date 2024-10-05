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