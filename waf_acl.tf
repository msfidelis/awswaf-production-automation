resource "aws_wafregional_web_acl" "WAFWebACL" {
    name        = format("%s-web-acl", var.waf_name)

    metric_name = "SecurityAutomationsMaliciousRequesters"

    default_action { type = "ALLOW" }

    rule {
        action { type = "BLOCK" }
        priority = 1
        rule_id  = aws_wafregional_rule.bad_ips_rule.id
    }

    rule {
        action { type = "BLOCK" }
        priority = 2
        rule_id  = aws_wafregional_rule.regex_uri.id
    }

    rule {
        action { type = "BLOCK" }
        priority = 3
        rule_id  = aws_wafregional_rule.regex_body.id
    }

    rule {
        action { type = "BLOCK" }
        priority = 4
        rule_id  = aws_wafregional_rule.sql_injection_rule.id
    }

    rule {
        action { type = "BLOCK" }
        priority = 5
        rule_id  = aws_wafregional_rule.xss_rule.id
    }

    rule {
        action { type = "BLOCK" }
        priority = 6
        rule_id  = aws_wafregional_rule.generic_insecuire_rules_qs.id
    }

    rule {
        action { type = "BLOCK" }
        priority = 7
        rule_id  = aws_wafregional_rule.generic_insecuire_rules_uri.id
    }


    rule {
        action { type = "BLOCK" }
        priority = 8
        rule_id  = aws_wafregional_rate_based_rule.ddos_ip_rule.id
        type     = "RATE_BASED"
    }

}