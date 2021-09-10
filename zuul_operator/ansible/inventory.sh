#!/usr/bin/env bash
#
# Dynamic inventory for ansible to use terraform output
#
###################################################################################################

cat << EOM
{
    "control_planes": {
        "hosts": $(terraform -chdir=../terraform output -json | jq '.control_planes.value')
    },
    "worker_nodes": {
        "hosts": $(terraform -chdir=../terraform output -json | jq '.worker_nodes.value')
    }
}
EOM