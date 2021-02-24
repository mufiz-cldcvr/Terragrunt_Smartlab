provider "aws" {
  region                  = "us-west-2"
  profile                 = "mufiz@cldcvr.com"
}
resource "aws_elasticsearch_domain" "example" {
  domain_name           = "example"
  elasticsearch_version = "7.8"
  cluster_config {
    instance_type = "t2.small.elasticsearch"
    instance_count = 1
  }
  snapshot_options {
    automated_snapshot_start_hour = 23
  }
    ebs_options{
        ebs_enabled = true
        volume_size = 10
    }
    access_policies = <<POLICY
    {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "*"
        ]
      },
      "Action": [
        "es:*"
      ],
      "Resource": "arn:aws:es:us-east-1:626505363333:domain/example/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "es:*"
      ],
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": [
            "*"
          ]
        }
      },
      "Resource": "arn:aws:es:us-east-1:626505363333:domain/example/*"
    }
  ]
}
POLICY
  tags = {
    Domain = "TestDomain"
  }
}

