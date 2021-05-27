#!/usr/bin/env bash
#
# Dynamic inventory for ansible to use terraform output
#
###################################################################################################

echo "{ \"instances\": { \"hosts\": "$(terraform -chdir=../terraform output -json | jq '.vip.value')" } }"
