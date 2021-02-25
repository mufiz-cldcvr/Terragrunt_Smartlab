locals {
   # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
  region = local.region_vars.locals.region
  zones = local.region_vars.locals.zones
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "git@github.com:Terragrunt_smartlab/modules/aws/elasticsearch.git//?ref=v0.0.1"
  }

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  tags = {
    ManagedBy   = "CloudCover"
    CreatedBy   = "Terraform"
    Environment = "${local.env}"
  }
}


