variable "aws_region" {
    type = string
    default = "us-east-1"
    description = "sets aws region"
    
}

variable "inbound_ports" {
    type =  list(number)
    default = [80, 443, 22]
}


variable "domain_name" {
  default    = "escuze.me"
  type        = string
  description = "Domain name"
}
