#!/usr/bin/env bash
#
# Dynamic inventory for ansible to use terraform output
#
###################################################################################################

cat << EOM
{
    "zuul": {
        "hosts": $(terraform -chdir=../terraform output -json | jq '.zuul_ips.value')
    }
}
EOM
