output "idt-opsgenie-webhook-url" {
  value       = module.idt-opsgenie-webhook.function_url
  description = "The URL of the deployed Lambda"
}

