#!/usr/bin/env bash
#
# Helper script to manage kubernetes test clusters
#
##################################################################################################

connect() {
  instance_number=0

  # if you've passed a parameter to select a certain instance
  if test $# -eq 1; then
    instance_number="$1"
  fi

  ssh -oStrictHostKeyChecking=no ubuntu@"$(terraform -chdir=terraform output -json | jq -r '.control_planes.value['"$instance_number"']')"
}

tfup() {
  cd terraform || exit
  OS_CLOUD=betacloud terraform apply -auto-approve
  cd .. || exit
}

tfdown() {
  cd terraform || exit
  OS_CLOUD=betacloud terraform destroy -auto-approve
  cd .. || exit
}

tfreup() {
  tfdown
  tfup
}

aup() {
  cd ansible || exit
  ansible-playbook main.yaml
  cd .. || exit
}

aping() {
  cd ansible || exit
  ansible all -u ubuntu -m ping
  cd .. || exit
}

if test -z "$1"; then
  echo "Select a mode: "
  declare -F | cut -d" " -f 3
else
  if test -z "$2"; then
    $1
  else
    $1 "$2"
  fi
fi
