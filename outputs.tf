output "arn" {
  description = "ARN of the trail"
  value = aws_cloudtrail.trail.arn
}

output "home_region" {
  description = "Region in which the trail was created"
  value = aws_cloudtrail.trail.home_region
}
