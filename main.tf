terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + OpsGenie Integration

# Details: https://github.com/indentapis/integrations/tree/c31c0a2f5371078d198ff8ae1a847404c628620e/packages/stable/indent-integration-opsgenie
# Last Change: https://github.com/indentapis/integrations/commit/c31c0a2f5371078d198ff8ae1a847404c628620e

module "idt-opsgenie-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-opsgenie-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/opsgenie-c31c0a2f5371078d198ff8ae1a847404c628620e-function.zip"
    deps_key     = "webhooks/aws/lambda/opsgenie-c31c0a2f5371078d198ff8ae1a847404c628620e-deps.zip"
  }
  env = {
    OPSGENIE_KEY            = var.opsgenie_key
    AUTO_APPROVAL_DURATION  = var.auto_approval_duration
    AUTO_APPROVAL_SCHEDULES = var.auto_approval_schedules
  }
}

