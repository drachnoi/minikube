#!/bin/bash
set -e
source ./env-vars.sh

if [ ! "$#" -eq 1 ]; then
  echo "No arguments supplied"
  exit 1
fi

if [ "$1" != "plan" -a "$1" != "apply" ]; then
  echo "Either 'plan' or 'apply' must be provided as arguments"
  exit 1
fi

terraform $1 \
  -var "do_token=${DO_PAT}" \
  -var "pub_key=$SSH_PUB_KEY_PATH" \
  -var "pvt_key=$SSH_PVT_KEY_PATH" \
  -var "ssh_fingerprint=$(ssh-keygen -E md5 -lf $SSH_PUB_KEY_PATH | sed -n 's/.*\sMD5:\(.*\)\s.*\s.*/\1/p')"
