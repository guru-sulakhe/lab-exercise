# Terraform AWS Setup for Jenkins Master and Agent with Route53 DNS

This Terraform configuration sets up the following infrastructure on AWS:

- A Jenkins master server on an EC2 instance
- A Jenkins agent node on a separate EC2 instance
- Route 53 DNS records for both instances
- User data scripts for automated provisioning
- Tagged and sized EBS root volumes

# Disk & Filesystem Resize
* Resize partitions and logical volumes on the root disk.

# Installed services in the jenkins_agent server:
* Java
* Terraform
* Python
* Nodejs
* Docker    
* Helm


