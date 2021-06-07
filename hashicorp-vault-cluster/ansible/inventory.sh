#!/usr/bin/env bash
#
# Dynamic inventory for ansible to use terraform output
#
###################################################################################################

cat << EOM
{
    "unsealer": {
        "hosts": $(terraform -chdir=../terraform output -json | jq '.unsealer_ips.value')
    },
    "cluster": {
        "hosts": $(terraform -chdir=../terraform output -json | jq '.cluster_ips.value')
    }
}
EOM
