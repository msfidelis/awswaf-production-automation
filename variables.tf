variable "waf_name" {
    default = "waf-production"
}

variable "aws_region" {
    default = "us-east-1"
}

variable "request_threshold"{
    default = 1000
}

##################################
####        Bad IP's    ####
##################################

variable "enable_bad_ips_rule" {
    default = true
}

variable "bad_ips" {
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

##################################
####  Regex Pattern on Body   ####
##################################

variable "enable_body_regex" {
    default = true
}

variable "body_regex" {
    type = list
    default = ["(?i)BODY_BLOCK_ME"]
}

##################################
#### Regex Pattern on Header  ####
##################################

variable "enable_header_regex" {
    default = true
}

variable "header_regex" {
    type = list
    default = ["(?i)blockme"]
}

##################################
####    Regex Pattern on URI  ####
##################################

variable "enable_uri_regex" {
    default = true
}

variable "uri_regex" {
    type = list(string)
    default = [
        "(?i)/block/me",
    ]
}
