resource "aws_wafregional_sql_injection_match_set" "sql_injection" {

  name  = format("%s-sql-injection", var.waf_name)

  sql_injection_match_tuple {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "QUERY_STRING"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "BODY"
    }

    text_transformation = "URL_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "BODY"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "URI"
    }

    text_transformation = "URL_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "URI"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "HEADER"
      data = "Cookie"
    }

    text_transformation = "URL_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "HEADER"
      data = "Cookie"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "HEADER"
      data = "Authorization"
    }

    text_transformation = "URL_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "HEADER"
      data = "Authorization"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }
}


resource "aws_wafregional_rule" "sql_injection_rule" {
  name        = format("%s-sql-injection-rule", var.waf_name)
  metric_name = "SecurityAutomationsSqlInjectionRule"

  predicate {
    type    = "SqlInjectionMatch"
    data_id = aws_wafregional_sql_injection_match_set.sql_injection.id
    negated = false
  }
}
