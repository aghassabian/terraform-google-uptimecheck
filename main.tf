
locals {
  endpoint_credentials = {
    for service, vals in var.uptimechecks :
    service => {
      endpoint_username = vals["endpoint_username"]
      endpoint_password = vals["endpoint_password"]
    } if vals["endpoint_username"] != null
  }
  endpoint_content_matcher = {
    for service, vals in var.uptimechecks :
    service => {
      matcher_content      = vals["matcher_content"]
      matcher              = vals["matcher"]
      matcher_json_path    = vals["matcher_json_path"]
      matcher_json_matcher = vals["matcher_json_matcher"]
    } if vals["matcher"] != null
  }
  channel_credentials = {
    for channel, vals in var.notification_channels :
    channel => {
      pagerduty_token = vals["pagerduty_token"]
      slack_token = vals["slack_token"]
    } if vals["pagerduty_token"] != null || vals["slack_token"] != null
  }
}

resource "google_monitoring_uptime_check_config" "https" {
  for_each = var.uptimechecks
  display_name = each.value.uptimecheck_name
  timeout      = coalesce(each.value.uptime_check_timeout, "10s")
  period       = coalesce(each.value.request_period, "60s")
  http_check {
    path         = coalesce(each.value.uptime_check_uri, "/")
    port         = coalesce(each.value.service_port, 443)
    request_method = coalesce(each.value.request_method, "GET")
    use_ssl      = true
    validate_ssl = true
    dynamic "auth_info" {
      for_each = {
        for k, v in local.endpoint_credentials :
          k => v if each.value.uptimecheck_name == k
      }
      content {
        username  = auth_info.value["endpoint_username"]
        password   = auth_info.value["endpoint_password"]
      }
    }
  }
  monitored_resource {
    type = coalesce(each.value.uptime_check_resource_type, "uptime_url")
    labels = {
      host = each.value.uptime_check_url
    }
  }
  dynamic "content_matchers" {
    for_each = {
      for k, v in local.endpoint_content_matcher :
        k => v if each.value.uptimecheck_name == k
    }
    content {
      content = content_matchers.value["matcher_content"]
      matcher = content_matchers.value["matcher"]
      json_path_matcher {
        json_path    = content_matchers.value["matcher_json_path"]
        json_matcher = content_matchers.value["matcher_json_matcher"]
      }
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_monitoring_notification_channel" "notification_channel" {
  for_each = var.notification_channels
  display_name = each.value.notification_channel_name
  description  = each.value.channel_description
  type         = each.value.channel_type
  labels = {
    email_address = each.value.channel_email_address
    channel_name  = each.value.slack_channel
  }
  dynamic "sensitive_labels" {
    for_each = {
      for k, v in local.channel_credentials :
        k => v if each.value.notification_channel_name == k
    }
    content {
      auth_token  = sensitive_labels.value["slack_token"]
      service_key = sensitive_labels.value["pagerduty_token"]
    }
  }
}

resource "google_monitoring_alert_policy" "uptime_check_alert_policy" {
  for_each = var.alert_policies
  display_name          = each.value.policy_name
  combiner              = coalesce(each.value.alert_combiner, "OR")
  notification_channels = [google_monitoring_notification_channel.notification_channel[each.value.notification_channel_name].id]
  conditions {
    display_name = each.value.policy_name
    condition_threshold {
      filter     = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND metric.label.check_id=\"${google_monitoring_uptime_check_config.https[each.value.uptimecheck_name].uptime_check_id}\" AND resource.type=\"uptime_url\""
      duration   = coalesce(each.value.alert_duration, "60s")
      comparison = coalesce(each.value.alert_comparison, "COMPARISON_GT")
      aggregations {
        alignment_period     = coalesce(each.value.aggregations_alignment_period, "1200s")
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        per_series_aligner   = "ALIGN_NEXT_OLDER"
        group_by_fields      = ["resource.label.*"]
      }
      threshold_value = coalesce(each.value.alert_threshold_value, "1.0")
      trigger {
        count = coalesce(each.value.alert_trigger_count, "1")
      }
    }
  }
  depends_on = [google_monitoring_uptime_check_config.https]
}

