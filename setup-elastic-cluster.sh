#!/bin/bash

PATH_TO_SSH_KEY="sshkey.private"
SSH_USER="root"

PATH_TO_SCRIPT=$(readlink -f "$0")
base=$(dirname "$PATH_TO_SCRIPT")

cd "$BASE"

function ans() {
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory-file "hosts" --private-key "$PATH_TO_SSH_KEY" -u SSH_USER "$@"
}

ans setup-k3s.playbook
ans setup-elastic.playbook
