#!/bin/bash -e

AWS_REGION=""
AWS_ACCESS_KEY=""
AWS_SECRET=""
USERNAME=""
PASSWORD=""

APP="$1"
ENV="$2"
COUNT="$3"
SIZE="$4"

terraform apply -var "access_key=${AWS_ACCESS_KEY}" -var "secret_key=${AWS_SECRET}" -var 'region=us-east-1' -var "db_username=${USERNAME}" -var "db_password=${PASSWORD}" -var "app_name=${APP}" -var "environment=${ENV}" -var "instance_type=${SIZE}"
export terraform_inventory=$(which terraform-inventory)
export PUBLIC_ACCESS_POINT=$(terraform output | grep app_entrypoint_address | cut -d = -f2)
export DB_URL=$(cat terraform.tfstate | grep endpoint | cut -d : -f2- | tr -d '"' | tr -d , | tr -d ' ')
export ansible_params="DB_HOST=${DB_URL} DB_USER=${USERNAME} -var DB_PASS=${PASSWORD}"
TF_STATE=terraform.tfstate ansible-playbook --inventory-file=${terraform_inventory} ./ansible/docker-wordpress.yml --extra-vars "${ansible_params}" --user ubuntu --private-key=./devtest.pem -v


echo "${PUBLIC_ACCESS_POINT}"
