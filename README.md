# terraform-aws-cloud_config

This is a super simple example showing how to inject user data into your newly created EC2 instance
Be warned it's on a public subnet with basic security group.

Steps would be along the lines of

```
#generate keypair in keys/ami_keys keys/ami_keys.pub

terraform plan
terraform apply

ssh-add keys/ami_keys

ssh ec2-user@XXX.XXX.XXX.XXX

which docker
```
