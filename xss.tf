resource "aws_wafregional_xss_match_set" "xss" {

  name  = format("%s-xss", var.waf_name)

  xss_match_tuple {
    field_to_match {
      type = "QUERY_STRING"
    }

    text_transformation = "URL_DECODE"
  }

  xss_match_tuple {
    field_to_match {
      type = "QUERY_STRING"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  xss_match_tuple {
    field_to_match {
      type = "BODY"
    }

    text_transformation = "URL_DECODE"
  }

  xss_match_tuple {
    field_to_match {
      type = "BODY"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  xss_match_tuple {
    field_to_match {
      type = "URI"
    }

    text_transformation = "URL_DECODE"
  }

  xss_match_tuple {
    field_to_match {
      type = "URI"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  xss_match_tuple {
    field_to_match {
      type = "HEADER"
      data = "Cookie"
    }

    text_transformation = "URL_DECODE"
  }

  xss_match_tuple {
    field_to_match {
      type = "HEADER"
      data = "Cookie"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }
}

resource "aws_wafregional_rule" "xss_rule" {
  name        = format("%s-xss-rule", var.waf_name)
  metric_name = "SecurityAutomationsXssRule"

  predicate {
    type    = "XssMatch"
    data_id = aws_wafregional_xss_match_set.xss.id
    negated = false
  }
}