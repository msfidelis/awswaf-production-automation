resource "aws_wafregional_ipset" "ip_blacklist" {

    name  = "${var.waf_name}-ip-blacklist"

    dynamic "ip_set_descriptor" {
        for_each = var.blacklist_ips
        content {
            type    = ip_set_descriptor.value.type
            value   = ip_set_descriptor.value.value
        }
    }
}

resource "aws_wafregional_rule" "ip_blacklist_rule" {
    depends_on  = [ aws_wafregional_ipset.ip_blacklist ]
    name        = "${var.waf_name}-ip-blacklist-rule"
    metric_name = "SecurityAutomationsBlacklistRule"

    predicate {
        type    = "IPMatch"
        data_id = "${aws_wafregional_ipset.ip_blacklist.id}"
        negated = false
    }
}
