#!/bin/zsh
#
# ssh -i /Users/columbia/Documents/osism/testbed-edge/secrets/id_rsa.operator dragon@192.168.34.11
#
##########################################
cd /Users/columbia/Documents/betacloud/playground/testbed || exit 1
while true; do
  timestamp=$(date +"%Y-%m-%d-%H-%M")
  OS_CLOUD=testbed terraform apply -auto-approve > "logs/${timestamp}_apply.log"
  echo "sleep 5 seconds after apply"
  sleep 5
  OS_CLOUD=testbed terraform destroy -auto-approve > "logs/${timestamp}_destroy.log"
  echo "sleep 5 seconds after destroy"
  sleep 5
done
