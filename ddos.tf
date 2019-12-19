resource "aws_wafregional_ipset" "ddos_ip" {
  name  = "${var.waf_name}-ddos-ip"
}

resource "aws_wafregional_rate_based_rule" "ddos_ip_rule" {
  depends_on  = ["aws_wafregional_ipset.ddos_ip"]
  name        = "${var.waf_name}-ddos-ip"
  metric_name = "SecurityAutomationsHttpFloodRule"

  rate_key   = "IP"
  rate_limit = "${var.request_threshold}"

  predicate {
    data_id = "${aws_wafregional_ipset.ddos_ip.id}"
    negated = false
    type    = "IPMatch"
  }
}