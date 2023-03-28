terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + OpsGenie Integration

# Details: https://github.com/indentapis/integrations/tree/6159654f374c3419e5f42cdf1e8787d02537d4b5/packages/stable/indent-integration-opsgenie
# Last Change: https://github.com/indentapis/integrations/commit/6159654f374c3419e5f42cdf1e8787d02537d4b5

module "idt-opsgenie-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-opsgenie-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/opsgenie-6159654f374c3419e5f42cdf1e8787d02537d4b5-function.zip"
    deps_key     = "webhooks/aws/lambda/opsgenie-6159654f374c3419e5f42cdf1e8787d02537d4b5-deps.zip"
  }
  env = {
    OPSGENIE_KEY            = var.opsgenie_key
    AUTO_APPROVAL_DURATION  = var.auto_approval_duration
    AUTO_APPROVAL_SCHEDULES = var.auto_approval_schedules
  }
}

