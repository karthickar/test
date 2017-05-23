#!/bin/bash -e

AWS_REGION=""
AWS_KEY_PAIR_NAME=""
AWS_ACCESS_KEY=""
AWS_SECRET=""

APP="$1"
ENV="$2"
COUNT="$3"
SIZE="$4"

terraform destroy -var "access_key=${AWS_ACCESS_KEY}" -var "secret_key=${AWS_SECRET}" -var 'region=us-east-1' -var "aws_key_pair_name=${AWS_KEY_PAIR_NAME}" -var "db_username=${DB_USERNAME}" -var "db_password=${DB_PASSWORD}" -var "app_name=${APP}" -var "environment=${ENV}" -var "instance_type=${SIZE}"
