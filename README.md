<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.0.0, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.29.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_alert_policy.uptime_check_alert_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |
| [google_monitoring_notification_channel.notification_channel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_monitoring_uptime_check_config.https](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_uptime_check_config) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_policies"></a> [alert\_policies](#input\_alert\_policies) | GCP Alert Policy parameters | <pre>map(object({<br>    aggregations_alignment_period = optional(string)<br>    alert_combiner = optional(string)<br>    alert_comparison = optional(string)<br>    alert_duration = optional(string)<br>    alert_threshold_value = optional(string)<br>    alert_trigger_count = optional(number)<br>    notification_channel_name = string<br>    policy_name = string<br>    uptimecheck_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_notification_channels"></a> [notification\_channels](#input\_notification\_channels) | Alerts notification channels parameters | <pre>map(object({<br>    channel_description = string<br>    channel_email_address = optional(string)<br>    notification_channel_name = string<br>    channel_type = string<br>    pagerduty_token = optional(string)<br>    slack_channel = optional(string)<br>    slack_token     = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_uptimechecks"></a> [uptimechecks](#input\_uptimechecks) | GCP Uptimecheck specification | <pre>map(object({<br>    endpoint_username = optional(string)<br>    endpoint_password = optional(string)<br>    matcher_content = optional(string)<br>    matcher         = optional(string)<br>    matcher_json_path       = optional(string)<br>    matcher_json_matcher    = optional(string)<br>    request_method = optional(string)<br>    uptimecheck_name = string<br>    service_port = optional(number)<br>    uptime_check_resource_type = optional(string)<br>    uptime_check_timeout = optional(string)<br>    uptime_check_uri = string<br>    uptime_check_url = string<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->