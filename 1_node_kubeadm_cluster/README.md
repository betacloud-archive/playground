# Single node kubernetes cluster

This repository should represent an edge example deployment for a single node kubernetes cluster.
It depends on [tibeer/_tfmodules](https://github.com/tibeer/_tfmodules). Clone it next to this repository.
Included components:
- some basic packages
- kubeadm cluster
- calico network
- helm
- metallb
- nginx-ingress
- metrics-server


## Requirements

You need to have terraform, ansible and jq installed on your local machine.
An instance with minimum 2 Cores and 2GB of memory. For storage 7GB should be enough.
You also need to download galaxy roles:
```bash
ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.kubernetes
ansible-galaxy install geerlingguy.helm
```


## How to deploy on OpenStack

*Preparation*
Download the `*-openrc.sh` script from the horizon dashboard and put it into the terraform directory.

*Deploy VM*
```bash
cd terraform
source XYZ-openrc.sh  # the script you downloaded
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

Keep in mind that you need to define a (default) storage class first with some kind of backend.
When thinking of small deployments (2 Cores, 2GB of memory) `hostPath` might be useful.
`longhorn` would also work (with only a single replica).

```bash
./s.sh
helm repo add gitea https://dl.gitea.io/charts/
helm install gitea gitea/gitea -f example_giteaHelmValues.yaml --set 'ingress.hosts[0]=git.'$(curl -s ifconfig.io)'.nip.io'
```
