resource "aws_wafregional_regex_pattern_set" "uri" {
    name                  = "${var.waf_name}-uri-regex"
    regex_pattern_strings = var.uri_regex
}

resource "aws_wafregional_regex_match_set" "regex_uri" {
    name = "${var.waf_name}-uri-regex"

    regex_match_tuple {
        field_to_match {
            type = "URI"
        }
        regex_pattern_set_id = aws_wafregional_regex_pattern_set.uri.id
        text_transformation  = "COMPRESS_WHITE_SPACE"
    }
}

resource "aws_wafregional_rule" "regex_uri" {
  name        = "${var.waf_name}-regex-uri"
  metric_name = "WAFMetricRegexUri"

  predicate {
    type    = "RegexMatch"
    data_id = aws_wafregional_regex_match_set.regex_uri.id
    negated = false
  }
}