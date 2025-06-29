#  Terraform EKS Cluster Deployment with SSH Access and Custom Node Group

This Terraform configuration sets up a complete **Amazon EKS (Elastic Kubernetes Service)** cluster using the official [terraform-aws-modules/eks/aws](https://github.com/terraform-aws-modules/terraform-aws-eks) module. It includes:

- Publicly accessible EKS Control Plane
- Managed node group with Spot instances
- SSH key integration via EC2 Key Pair
- Integration with existing VPC, Subnets, and Security Groups
- Essential add-ons (CoreDNS, kube-proxy, VPC CNI, etc.)
- IAM policies for EBS, EFS, and Load Balancer access

---

##  Resources Created

### 1. aws_key_pair.eks

resource "aws_key_pair" "eks"

## IAM Policies Attached to Node Group
These AWS managed policies are attached to the node IAM role:

* AmazonEBSCSIDriverPolicy

* AmazonElasticFileSystemFullAccess

* ElasticLoadBalancingFullAccess

* These allow Kubernetes workloads on EKS to interact with:

* Elastic Block Store (EBS) volumes

* Elastic File System (EFS)

* Elastic Load Balancers

## To Access the cluster
* aws eks --region us-east-1 update-kubeconfig --name lab-exercise-dev