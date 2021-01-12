This repo contains example files for TFE 201 training.
- basic examples
- jenkins example

## How To Run basic basic example

## How To Run Jenkins example
Configure the TFE workspace variables,
* pod_name - student pod name
* vpc_name - vpc name
* machine_type - t2.micro
* ec2_key pair
* ami_id - ubuntu-18.04-amd64-server (ami-0d0032af1da6905c7)

Configure the TFE environment variables
* AWS_DEFAULT_REGION
* AWS_ACCESS_KEY_ID 
* AWS_SECRET_ACCESS_KEY 

Create a Team API token and use it in the .terraformrc
```
#cp .terraformrc ~/ or
export TF_CLI_CONFIG_FILE=./terraformrc
export token=xxxxxx (TFE team token)
terraform init -backend-config="token=$token"
terraform apply
terraform destroy
```
