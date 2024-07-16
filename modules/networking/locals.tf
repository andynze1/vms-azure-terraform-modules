locals {
  stage_tags = {
    "environment" = "stage",
    "tier"        = 3,
    "department"  = "IT"
  }

  dev_tags = {
    "environment" = "dev",
    "tier"        = 2,
    "department"  = "IT"
  }

  prod_tags = {
    "environment" = "prod",
    "tier"        = 1,
    "department"  = "IT"
  }

  network_security_group_rules = [
    {
      priority               = 200
      destination_port_range = "22"
      source_address_prefix  = var.my_ip_address
    },
    {
      priority               = 300
      destination_port_range = "8080"
    },
    {
      priority               = 400
      destination_port_range = "8081"
    },
    {
      priority               = 500
      destination_port_range = "9000"
    },
    {
      priority               = 700
      destination_port_range = "80"
    }
  ]
}
