# Set common variables for the account. This is automatically pulled in in the root terragrunt.hcl configuration to
# configure the remote state bucket and pass forward to the child modules as inputs.
locals {
  remote_bucket_name = "terraform-smartlab-state"
  remote_bucket_key  = "terraform/state"
}