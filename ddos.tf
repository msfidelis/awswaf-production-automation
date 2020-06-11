resource "aws_wafregional_ipset" "ddos_ip" {
  name  = format("%s-ddos-ip", var.waf_name)
}

resource "aws_wafregional_rate_based_rule" "ddos_ip_rule" {
  name        = format("%s-ddos-ip", var.waf_name)
  metric_name = "SecurityAutomationsHttpFloodRule"

  rate_key   = "IP"
  rate_limit = var.request_threshold

  predicate {
    data_id = aws_wafregional_ipset.ddos_ip.id
    negated = false
    type    = "IPMatch"
  }
}