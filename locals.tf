locals {
  default_tags = {
    "com.thorsten-hans.conference" : "ESPC2021"
    "com.thorsten-hans.retention" : "1-month"
  }

  tags = merge(local.default_tags, var.custom_tags)
}
