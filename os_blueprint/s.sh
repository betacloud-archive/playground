#!/usr/bin/env bash
#
# Helper script to connect to the instances (defaults to first one)
#
##################################################################################################

instance_number=0

# if you've passed a parameter to select a certain instance
if test $# -eq 1; then
  instance_number="$1"
fi

ssh ubuntu@"$(terraform -chdir=terraform output -json | jq -r '.vip.value['"$instance_number"']')"
