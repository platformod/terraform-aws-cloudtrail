# AWS Cloudtrail Terraform module

Terraform module which creates AWS Cloudtrail resources.

This is an opinionated tool for creating a fairly boring Cloudtrail setup.

Features:
* Multi Region Trail
* Includes Global Events
* Includes Management Events
* Include Insights events
* No Data events
  * If you need data events, you should write another trail with specific event selectors to manage scale and cost.

## Usage

```hcl
# To prevent a dependency loop and pass AWS runtime validations, create
# the storage first, providing the computed arn of the trail to the
# cloudtrail_s3 module

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

locals {
  name = "zombocom-main"
  arn = "arn:${data.aws_partition.current}:cloudtrail:${data.aws_region.current}:${data.aws_caller_identity.account_id}:trail/${local.name}"
}

module "storage" {
  source = "platformod/cloudtrail-s3"
  version = 0.CHANGE_ME

  # Creates a "${local.name}-cloudtrail" bucket
  name = local.name

  account_trails = [
    {
      account = data.aws_caller_identity.current.account_id ,
      arn = local.arn
    },
  ]
}

module "trail" {
  source  = "platformod/cloudtrail"
  version = 0.CHANGEME

  name      = local.name
  s3_bucket = "${local.name}-cloudtrail"
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.34.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.trail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | A name for the trail, ideally the same value you used for the bucket name prefix | `string` | n/a | yes |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | The name od the S3 bucket you created to store the logs | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the trail |
| <a name="output_home_region"></a> [home\_region](#output\_home\_region) | Region in which the trail was created |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Tests

The tests in this repo will create and destroy real resources at AWS and incur cost. Please be careful when running them.

## License

MPL-2.0 Licensed. See [LICENSE](LICENSE).
