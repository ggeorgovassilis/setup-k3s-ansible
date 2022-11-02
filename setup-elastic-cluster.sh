#!/bin/bash

PATH_TO_SSH_KEY="${PATH_TO_SSH_KEY:-sshkey.private}"
SSH_USER="${SSH_USER:-root}"
ANSIBLE_HOSTS="${ANSIBLE_HOSTS:-hosts}"

PATH_TO_SCRIPT=$(readlink -f "$0")
base=$(dirname "$PATH_TO_SCRIPT")

cd "$BASE"

function ans() {
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory-file "$ANSIBLE_HOSTS" --private-key "$PATH_TO_SSH_KEY" -u "$SSH_USER" "$@"
}

ans playbook-setup-k3s.yml
ans playbook-setup-elastic.yml
