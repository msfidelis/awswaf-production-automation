resource "aws_wafregional_regex_pattern_set" "body" {
    name                  = "${var.waf_name}-body-regex"
    regex_pattern_strings = var.body_regex
}

resource "aws_wafregional_regex_match_set" "regex_body" {
    name = "${var.waf_name}-body-regex"

    regex_match_tuple {
        field_to_match {
            type = "BODY"
        }
        regex_pattern_set_id = aws_wafregional_regex_pattern_set.body.id
        text_transformation  = "HTML_ENTITY_DECODE"
    }
}

resource "aws_wafregional_rule" "regex_body" {
  name        = "${var.waf_name}-regex-body"
  metric_name = "WAFMetricRegexBody"

  predicate {
    type    = "RegexMatch"
    data_id = aws_wafregional_regex_match_set.regex_body.id
    negated = false
  }
}
