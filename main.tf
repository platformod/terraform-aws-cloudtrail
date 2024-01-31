# An opnionated cloudtrail.
# Single trail, all management events, no data events

resource "aws_cloudtrail" "trail" {
  #checkov:skip=CKV_AWS_252:We will offworld and parse these logs someplace else, do not need SNS
  #checkov:skip=CKV_AWS_35:These are encrypted at rest in S3

  name           = var.name
  s3_bucket_name = var.s3_bucket

  enable_log_file_validation = true

  include_global_service_events = true
  is_multi_region_trail         = true

  insight_selector {
    insight_type = "ApiCallRateInsight"
  }

  insight_selector {
    insight_type = "ApiErrorRateInsight"
  }

  event_selector {
    include_management_events = true
  }

  tags = {
    Name = var.name
  }
}
