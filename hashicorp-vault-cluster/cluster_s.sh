#!/usr/bin/env bash
#
# Helper script to connect to the cluster instances (defaults to first one)
#
##################################################################################################

instance=0

# if you've passed a parameter to select a certain instance
if test $# -eq 1; then
  instance="$1"
fi

ssh ubuntu@"$(terraform -chdir=terraform output -json | jq -r '.cluster_ips.value['"$instance"']')"
