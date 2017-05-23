# How to run

install terraform-inventory in your box.

Start the env
`./startit.sh mydjango prod 1 t2.micro`

To remove it all:

`./destroy.sh mydjango prod 1 t2.micro`

# Requirements:

Here are the specs you want:

- OS: Ubuntu Server 14.04 64-bit
- App Server: Gunicorn/Nginx
- Python: 2.7
- Ansible
- Docker 1.10
- django docker image https://hub.docker.com/_/django/

# Deliverables:

(1) A GitHub repo with the Terraform configuration, Ansible playbook, Dockerfile, shell script(s) etc.
(2) A bash script that will:
- Launch the AWS infrastructure with EC2 servers.
- Begin the configuration management / bootstrapping of the server using Ansible.
- Finally start the blogging app as a Docker process.

DO NOT CHECK THIS INTO GITHUB WITH AWS KEYS.

Remember to use security groups to restrict port access. Prefix all of your AWS resources (when possible) with your
first name (example: firstname-lastname.domain.com).

We should be able to perform the following commands and then interact with a functioning app in the browser.

cloud-automation.sh <app> <environment> <num_servers> <server_size>
ex: ./startit.sh mydjango prod 1 t2.micro

This should return the IP address of the load-balanced Wordpress application, after which, we can open a browser to
http://IP and see the django app come up!
