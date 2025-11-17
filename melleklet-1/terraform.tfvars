billing_account = {
  id = "xxx-xxx-xxx"
}

locations = {
  bq      = "EU"
  gcs     = "EU"
  logging = "global"
  pubsub  = []
}

organization = {
  domain      = "xxx.hu"
  id          = xxx
  customer_id = "xxx"
}

outputs_location = "~/fast-config"

prefix = "xxx"

workload_identity_providers = {
  gitlab = {
    issuer              = "gitlab"
    attribute_condition = "attribute.namespace_path==\"paripa\""
  }
}

cicd_repositories = {
  bootstrap = {
    branch            = null
    identity_provider = "gitlab"
    name              = "paripa/0-bootstrap"
    type              = "gitlab"
  }
  resman = {
    branch            = null
    identity_provider = "gitlab"
    name              = "paripa/1-resman"
    type              = "gitlab"
  }
  tenants = {
    branch            = null
    identity_provider = "gitlab"
    name              = "paripa/1-tenant-factory"
    type              = "gitlab"
  }
  vpcsc = {
    branch            = null
    identity_provider = "gitlab"
    name              = "paripa/1-vpcsc"
    type              = "gitlab"
  }
}
