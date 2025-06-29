# Terraform AWS Security Group Setup for MongoDB and EKS

This Terraform configuration sets up AWS Security Groups and ingress rules required to enable secure communication between:

- MongoDB EC2 instances
- EKS Node Group
- EKS Control Plane

It uses a reusable Terraform module sourced from GitHub to manage Security Groups consistently across the infrastructure.

---

## Modules Used

All Security Groups are created using the following module:
```hcl
source = "git::https://github.com/guru-sulakhe/terraform-aws-security-group.git?ref=main"
