# An opnionated cloudtrail.
# Single trail, all management events, no data events

resource "aws_cloudtrail" "trail" {
  name           = var.name
  s3_bucket_name = var.s3_bucket

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
