variable "waf_name" {
    default = "waf-production"
}

variable "aws_region" {
    default = "us-east-1"
}

variable "request_threshold"{
    default = 1000
}

variable "blacklist_ips" {
    type = list
    default = [
        {
            value   = "8.8.8.8/32"
            type    = "IPV4"
        },
        {
            value   = "9.9.9.9/32"
            type    = "IPV4"
        }
    ]
}

variable "body_regex" {
    type = list
    default = []
}

variable "header_regex" {
    type = list
    default = []
}

variable "uri_regex" {
    type = list(string)
    default = [
        "/block/me"
    ]
}
