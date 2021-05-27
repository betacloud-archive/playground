# OpenStack VM blueprint

This repository acts as a blueprint to deploy a VM in an OpenStack environment.
It depends on [tibeer/_tfmodules](https://github.com/tibeer/_tfmodules). Clone it next to this repository..


## Requirements

You need to have terraform, ansible and jq installed on your local machine.


## Deployment

*Preparation*
Download the `*-openrc.sh` script from the horizon dashboard and put it into the terraform directory.

*Deploy VM*
```bash
cd terraform
source XYZ-openrc.sh. # the file you downloaded
terraform init
terraform apply -auto-approve
cd ..
```

*Provision VM*
```bash
cd ansible
ansible-playbook main.yaml
cd ..
```
