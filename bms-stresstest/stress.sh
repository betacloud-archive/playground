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

echo "START" | ts >> "${LOG_PATH}"
terraform -chdir="${TF_STRESS_DIR}" apply -auto-approve
echo "RESULT APPLY: ${?}"| ts >> "${LOG_PATH}"
terraform -chdir="${TF_STRESS_DIR}" destroy -auto-approve
echo "RESULT DESTROY: ${?}"| ts >> "${LOG_PATH}"
echo "END" | ts >> "${LOG_PATH}"
