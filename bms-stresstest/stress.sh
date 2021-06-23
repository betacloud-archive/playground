#!/bin/bash
#
# Deploy and then destroy terraform bms instances.
# Add a cronjob to this script like this
# 0 0 * * *
# 
# Requirements: moreutils (to use "ts")
#
###############################################################################
LOG_PATH=/home/ubuntu/bms-stress.log
TF_STRESS_DIR=/home/ubuntu/bms-stresstest

export OS_AUTH_URL=http://192.168.34.10:5000
export OS_PROJECT_ID=290a2a9cb44d403e9aebc9c73700aa4e
export OS_PROJECT_NAME="admin"
export OS_USER_DOMAIN_NAME="Default"
export OS_PROJECT_DOMAIN_ID="default"
export OS_USERNAME="admin"
export OS_PASSWORD="wNNMXmvo6uaTFfgFpPXYMK5T6F6rauv1XPdwHyzn"
export OS_REGION_NAME="RegionOne"
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3

echo "START" | ts >> "${LOG_PATH}"
terraform -chdir="${TF_STRESS_DIR}" apply -auto-approve
echo "RESULT APPLY: ${?}"| ts >> "${LOG_PATH}"
terraform -chdir="${TF_STRESS_DIR}" destroy -auto-approve
echo "RESULT DESTROY: ${?}"| ts >> "${LOG_PATH}"
echo "END" | ts >> "${LOG_PATH}"
