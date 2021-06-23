# Zuul-CI deployment

This repository contains the SCS Zuul-CI installation setup.
Zuul-CI is a gating system which goes beyond normal CI-CD pipeline functionality.


### Github App

In oder to have Zuul-CI working with GitHub you need to setup a GitHub app.
A guide on how to setup this app can be found here:
https://github.com/tibeerorg/zuul_setup


### Infrastructure as Code (IaC)

Done via Terraform.
Export an os `OS_CLOUD` variable with the corresponding value of your OpenStack clouds.yaml to deploy.
```bash
cd terraform
terraform apply -auto-approve
```

### Provisioning

Done via Ansible.
```bash
cd ansible
ansible-playbook --extra-vars "webhook_token=webhooksecretvalue db_user_pass=userpassword db_root_pass=rootpassword" main.yaml
```

### License

Apache License 2.0
