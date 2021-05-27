# Three node kubernetes cluster on Hetzner cloud

This repository should represent an edge example deployment for a three node kubernetes cluster.
It depends on [tibeer/_tfmodules](https://github.com/tibeer/_tfmodules). Clone it next to this repository.
Included components:
- some basic packages
- kubeadm cluster
- calico network
- helm
- metallb
- nginx-ingress
- metrics-server
- longhorn


## Requirements

You need to have terraform, ansible and jq installed on your local machine.
Three instances with minimum 2 Cores and 2GB of memory. For storage 7GB per instance should be enough.


## How to deploy on Hetzer cloud

*Preparation*
Generate an access token from the web UI.

*Deploy VM*
```bash
cd terraform
source hcloud.sh
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


## Example workload

As an example workload you may want to deploy something like gitea.
The commands below would install you a small pod which is accessible via the `git.<your_public_ip>.nip.io` address.

```bash
./s.sh
helm repo add gitea https://dl.gitea.io/charts/
helm install gitea gitea/gitea -f example_giteaHelmValues.yaml --set 'ingress.hosts[0]=git.'$(curl -s ifconfig.io)'.nip.io'
```
