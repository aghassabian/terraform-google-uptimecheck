variable "authentication" {
  type = map(object({
    username = string
    password = string
  }))
  default     = {}
  description = "Credentials to get authenticated to hit the target endpoint"
}

variable "content_matcher" {
  type = map(object({
    matcher_content = string
    matcher         = string
    json_path       = string
    json_matcher    = string
  }))
  default     = {}
  description = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_uptime_check_config#nested_content_matchers"
}

variable "channel_authenitcation" {
  type = map(object({
    slack_token     = optional(string)
    pagerduty_token = optional(string)
  }))
  default     = {}
  description = "GCP monitoring notification channel token"
}

variable "alert_threshold_value" {
  type        = string
  default     = "1.0"
  description = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy#threshold_value"
}

variable "alert_trigger_count" {
  type        = number
  default     = 1
  description = "Number of time series to fail to trigger the alert"
}

variable "aggregations_alignment_period" {
  type        = string
  default     = "60s"
  description = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy#aggregations"
}

variable "alert_combiner" {
  type        = string
  default     = "OR"
  description = "Logical Operator for multiple conditions of an uptime check"
}

variable "alert_comparison" {
  type        = string
  default     = "COMPARISON_GT"
  description = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy#comparison"
}

variable "alert_duration" {
  type        = string
  default     = "60s"
  description = "The amount of time that a uptime check must fail to be considered failing"
}

variable "channel_description" {
  type        = string
  default     = ""
  description = "GCP monitoring notification channel description"
}

variable "channel_type" {
  type        = string
  description = "GCP monitoring notification channel type"
}

variable "channel_email_address" {
  type        = string
  default     = ""
  description = "GCP monitoring notification channel email address"
}

variable "request_method" {
  type        = string
  default     = "GET"
  description = "API request verb. Supported: GET|POST"
}

variable "service_name" {
  type        = string
  description = "Monitored service name"
}

variable "service_port" {
  type        = number
  default     = 443
  description = "Monitored URL port number"
}

variable "slack_channel" {
  type        = string
  default     = ""
  description = "Slack channel name to which the notifications would be sent"
}

variable "uptime_check_resource_type" {
  type        = string
  default     = "uptime_url"
  description = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_uptime_check_config#type"
}

variable "uptime_check_timeout" {
  type        = string
  default     = "60s"
  description = "Uptime check timeout duration"
}

variable "uptime_check_uri" {
  type        = string
  default     = "/"
  description = "Uptime check endpoint URI"
}

variable "uptime_check_url" {
  type        = string
  description = "URL or IP address of the service"
}
