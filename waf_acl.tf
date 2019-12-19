resource "aws_wafregional_web_acl" "WAFWebACL" {

    depends_on  = [
        aws_wafregional_rule.ip_blacklist_rule,
        aws_wafregional_rule.sql_injection_rule,
        aws_wafregional_rule.xss_rule,
        aws_wafregional_rate_based_rule.ddos_ip_rule
    ]

    name        = "${var.waf_name}-web-acl"

    metric_name = "SecurityAutomationsMaliciousRequesters"

    default_action { type = "ALLOW" }

    rule {
        action { type = "BLOCK" }
        priority = 1
        rule_id  = aws_wafregional_rule.ip_blacklist_rule.id
    }

    rule {
        action { type = "BLOCK" }
        priority = 2
        rule_id  = aws_wafregional_rule.regex_uri.id
    }

    // rule {
    //     action { type = "BLOCK" }
    //     priority = 2
    //     rule_id  = "${aws_wafregional_rate_based_rule.ddos_ip_rule.id}"
    // }

    rule {
        action { type = "BLOCK" }
        priority = 3
        rule_id  = aws_wafregional_rule.sql_injection_rule.id
    }

    rule {
        action { type = "BLOCK" }
        priority = 4
        rule_id  = aws_wafregional_rule.xss_rule.id
    }

}