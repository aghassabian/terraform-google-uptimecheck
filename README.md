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
| <a name="input_aggregations_alignment_period"></a> [aggregations\_alignment\_period](#input\_aggregations\_alignment\_period) | https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy#aggregations | `string` | `"60s"` | no |
| <a name="input_alert_combiner"></a> [alert\_combiner](#input\_alert\_combiner) | Logical Operator for multiple conditions of an uptime check | `string` | `"OR"` | no |
| <a name="input_alert_comparison"></a> [alert\_comparison](#input\_alert\_comparison) | https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy#comparison | `string` | `"COMPARISON_GT"` | no |
| <a name="input_alert_duration"></a> [alert\_duration](#input\_alert\_duration) | The amount of time that a uptime check must fail to be considered failing | `string` | `"60s"` | no |
| <a name="input_alert_threshold_value"></a> [alert\_threshold\_value](#input\_alert\_threshold\_value) | https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy#threshold_value | `string` | `"1.0"` | no |
| <a name="input_alert_trigger_count"></a> [alert\_trigger\_count](#input\_alert\_trigger\_count) | Number of time series to fail to trigger the alert | `number` | `1` | no |
| <a name="input_authentication"></a> [authentication](#input\_authentication) | Credentials to get authenticated to hit the target endpoint | <pre>map(object({<br>    username = string<br>    password = string<br>  }))</pre> | `{}` | no |
| <a name="input_channel_authenitcation"></a> [channel\_authenitcation](#input\_channel\_authenitcation) | GCP monitoring notification channel token | <pre>map(object({<br>    slack_token     = optional(string)<br>    pagerduty_token = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_channel_description"></a> [channel\_description](#input\_channel\_description) | GCP monitoring notification channel description | `string` | `""` | no |
| <a name="input_channel_email_address"></a> [channel\_email\_address](#input\_channel\_email\_address) | GCP monitoring notification channel email address | `string` | `""` | no |
| <a name="input_channel_type"></a> [channel\_type](#input\_channel\_type) | GCP monitoring notification channel type | `string` | n/a | yes |
| <a name="input_content_matcher"></a> [content\_matcher](#input\_content\_matcher) | https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_uptime_check_config#nested_content_matchers | <pre>map(object({<br>    matcher_content = string<br>    matcher         = string<br>    json_path       = string<br>    json_matcher    = string<br>  }))</pre> | `{}` | no |
| <a name="input_request_method"></a> [request\_method](#input\_request\_method) | API request verb. Supported: GET\|POST | `string` | `"GET"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Monitored service name | `string` | n/a | yes |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | Monitored URL port number | `number` | `443` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | Slack channel name to which the notifications would be sent | `string` | `""` | no |
| <a name="input_uptime_check_resource_type"></a> [uptime\_check\_resource\_type](#input\_uptime\_check\_resource\_type) | https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_uptime_check_config#type | `string` | `"uptime_url"` | no |
| <a name="input_uptime_check_timeout"></a> [uptime\_check\_timeout](#input\_uptime\_check\_timeout) | Uptime check timeout duration | `string` | `"60s"` | no |
| <a name="input_uptime_check_uri"></a> [uptime\_check\_uri](#input\_uptime\_check\_uri) | Uptime check endpoint URI | `string` | `"/"` | no |
| <a name="input_uptime_check_url"></a> [uptime\_check\_url](#input\_uptime\_check\_url) | URL or IP address of the service | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->