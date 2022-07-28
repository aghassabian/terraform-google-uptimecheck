variable uptimechecks {
  type        = map(object({
    endpoint_username = optional(string)
    endpoint_password = optional(string)
    matcher_content = optional(string)
    matcher         = optional(string)
    matcher_json_path       = optional(string)
    matcher_json_matcher    = optional(string)
    request_method = optional(string)
    request_period = optional(string)
    uptimecheck_name = string
    service_port = optional(number)
    uptime_check_resource_type = optional(string)
    uptime_check_timeout = optional(string)
    uptime_check_uri = string
    uptime_check_url = string
  }))
  default     = {}
  description = "GCP Uptimecheck specification"
}

variable notification_channels {
  type        = map(object({
    channel_description = string
    channel_email_address = optional(string)
    notification_channel_name = string
    channel_type = string
    pagerduty_token = optional(string)
    slack_channel = optional(string)
    slack_token     = optional(string)
  }))
  default     = {}
  description = "Alerts notification channels parameters"
}

variable alert_policies {
  type        = map(object({
    aggregations_alignment_period = optional(string)
    alert_combiner = optional(string)
    alert_comparison = optional(string)
    alert_duration = optional(string)
    alert_threshold_value = optional(string)
    alert_trigger_count = optional(number)
    notification_channel_name = string
    policy_name = string
    uptimecheck_name = string
  }))
  default     = {}
  description = "GCP Alert Policy parameters"
}
