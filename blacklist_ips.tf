resource "aws_wafregional_ipset" "ip_blacklist" {

    name  = format("%s-ip-blacklist", var.waf_name)

    dynamic "ip_set_descriptor" {
        for_each = var.blacklist_ips
        content {
            type    = ip_set_descriptor.value.type
            value   = ip_set_descriptor.value.value
        }
    }
}

resource "aws_wafregional_rule" "ip_blacklist_rule" {

    name        = format("%s-ip-blacklist-rule", var.waf_name)
    metric_name = "SecurityAutomationsBlacklistRule"

    predicate {
        type    = "IPMatch"
        data_id = aws_wafregional_ipset.ip_blacklist.id
        negated = false
    }
}
