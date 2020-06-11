resource "aws_wafregional_regex_pattern_set" "body" {
    name                  = format("%s-body-regex", var.waf_name)
    regex_pattern_strings = var.body_regex
}

resource "aws_wafregional_regex_match_set" "regex_body" {
    name = format("%s-body-regex", var.waf_name)

    regex_match_tuple {
        field_to_match {
            type = "BODY"
        }
        regex_pattern_set_id = aws_wafregional_regex_pattern_set.body.id
        text_transformation  = "HTML_ENTITY_DECODE"
    }
}

resource "aws_wafregional_rule" "regex_body" {
  name        = format("%s-regex-body", var.waf_name)
  metric_name = "WAFMetricRegexBody"

  predicate {
    type    = "RegexMatch"
    data_id = aws_wafregional_regex_match_set.regex_body.id
    negated = false
  }
}
