#!/bin/bash

#init terraform
terraform init

#validate terraform
terraform validate

#create key pair
./aws_config.sh

#create key pair
./ec2_keypair.sh

#run terraform
terraform apply -input=false -auto-approve