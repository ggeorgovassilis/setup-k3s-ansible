#!/bin/bash

PATH_TO_SSH_KEY="sshkey.private"
SSH_USER="root"

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
BASE=$(dirname "$SCRIPT")

cd "$BASE"

function ans() {
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory-file "hosts" --private-key "$PATH_TO_SSH_KEY" -u SSH_USER "$@"
}

ans setup-k3s-ansible/common.playbook
ans elastic.playbook
