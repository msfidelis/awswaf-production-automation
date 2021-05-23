resource "aws_wafregional_ipset" "bad_ips" {

    name  = format("%s-bad-ips", var.waf_name)

    dynamic "ip_set_descriptor" {
        for_each = var.bad_ips
        content {
            type    = ip_set_descriptor.value.type
            value   = ip_set_descriptor.value.value
        }
    }
}

resource "aws_wafregional_rule" "bad_ips_rule" {

    name        = format("%s-bad-ips-rule", var.waf_name)
    metric_name = "SecurityAutomationsBadIPSRule"

    predicate {
        type    = "IPMatch"
        data_id = aws_wafregional_ipset.bad_ips.id
        negated = false
    }
}
