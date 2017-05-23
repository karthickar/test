#!/bin/bash -e

AWS_REGION=""
AWS_ACCESS_KEY=""
AWS_SECRET=""

APP="$1"
ENV="$2"
COUNT="$3"
SIZE="$4"

terraform apply -var "access_key=${AWS_ACCESS_KEY}" -var "secret_key=${AWS_SECRET}" -var 'region=us-east-1' -var "app_name=${APP}" -var "environment=${ENV}" -var "instance_type=${SIZE}"
export terraform_inventory=$(which terraform-inventory)
export PUBLIC_ACCESS_POINT=$(terraform output | grep app_entrypoint_address | cut -d = -f2)
export DB_URL=$(cat terraform.tfstate | grep endpoint | cut -d : -f2- | tr -d '"' | tr -d , | tr -d ' ')
TF_STATE=terraform.tfstate ansible-playbook --inventory-file=${terraform_inventory} ./ansible/docker-django.yml --user ubuntu --private-key=./devtest.pem -v


echo "${PUBLIC_ACCESS_POINT}"
