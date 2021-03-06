sg_web terraform module
=======================

A terraform module with contains rules for a https only, which 
you can use with your service Terraform template.

Ports
-----
- TCP 443 (HTTPS)

Input Variables
---------------

- `security_group_name` - The name for your security group, e.g. `bluffdale_web_stage1`
- `vpc_id` - The VPC this security group should be created in.

Usage
-----

You can use these in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. `main.tf`

```
module "sg_web" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-igw.git//sg_https_only/"
  security_group_name = "${var.security_group_name}-web"
  vpc_id = "${var.vpc_id}"
  source_cidr_block = "${var.source_cidr_block}"
}
```

2. Setting values for the following variables, either through `terraform.tfvars` or `-var` arguments on the CLI

- security_group_name
- vpc_id
- source_cidr_block
