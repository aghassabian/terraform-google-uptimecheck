terraform {
  experiments = [module_variable_optional_attrs]
}

resource "google_monitoring_uptime_check_config" "https" {
  display_name = var.service_name
  timeout      = var.uptime_check_timeout
  http_check {
    path         = var.uptime_check_uri
    port         = var.service_port
    request_method = var.request_method
    use_ssl      = true
    validate_ssl = true
    dynamic "auth_info" {
      for_each = var.authentication
      content {
        username  = auth_info.value["username"]
        password   = auth_info.value["password"]
      }
    }
  }
  monitored_resource {
    type = var.uptime_check_resource_type
    labels = {
      host = var.uptime_check_url
    }
  }
  dynamic "content_matchers" {
    for_each = var.content_matcher
    content {
      content = content_matchers.value["matcher_content"]
      matcher = content_matchers.value["matcher"]
      json_path_matcher {
        json_path    = content_matchers.value["json_path"]
        json_matcher = content_matchers.value["json_matcher"]
      }
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_monitoring_alert_policy" "uptime_check_alert_policy" {
  display_name          = var.service_name
  combiner              = var.alert_combiner
  notification_channels = [google_monitoring_notification_channel.notification_channel.id]
  conditions {
    display_name = var.service_name
    condition_threshold {
      filter     = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND metric.label.check_id=\"${google_monitoring_uptime_check_config.https.uptime_check_id}\" AND resource.type=\"uptime_url\""
      duration   = var.alert_duration
      comparison = var.alert_comparison
      aggregations {
        alignment_period     = var.aggregations_alignment_period
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        per_series_aligner   = "ALIGN_NEXT_OLDER"
        group_by_fields      = ["resource.label.*"]
      }
      threshold_value = var.alert_threshold_value
      trigger {
        count = var.alert_trigger_count
      }
    }
  }
  depends_on = [google_monitoring_uptime_check_config.https]
}

resource "google_monitoring_notification_channel" "notification_channel" {
  display_name = var.service_name
  description  = var.channel_description
  type         = var.channel_type
  labels = {
    email_address = var.channel_email_address == "" ? null : var.channel_email_address
    channel_name  = var.slack_channel == "" ? null : var.slack_channel
  }
  dynamic "sensitive_labels" {
    for_each = var.channel_authenitcation
    content {
      auth_token  = lookup(sensitive_labels.value, "slack_token", null)
      service_key = lookup(sensitive_labels.value, "pagerduty_token", null)
    }
  }
}