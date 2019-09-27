# terraform-eks-with-weave

A basic example Kubernetes Cluster (EKS) with Weave CNI replacing the standard AWS CNI plugin, implemented in Terraform.

## Getting started

* Modify the example.tfvars file to fit your own parameters.
* `terraform plan -var-file="example.tfvars" -out="example.tfplan"`
* `terraform apply "example.tfplan"`
* `./setup-weave.sh`
* `./test-weave.sh`

## Notes

**Note:** This will create a new VPC, subnets, NAT Gateway instance, Internet Gateway, EKS Cluster with worker node autoscale groups.

After terraform creates all the resources, you can run the two included shell scripts. `setup-weave.sh` will remove the AWS CNI, install CNI genie, Weave, and deploy two simple example pods and services.

At this point you should terminate your existing worker nodes (that still use the AWS CNI) and wait for your new worker nodes to join the cluster.

`test-weave.sh` will wait for the hello-node test pods to become ready, and then execute a curl command inside one, talking to the other via the the service and vice versa. If successful, you'll see a HTTP 200 OK response from each service.
