#!/bin/bash
base="/home/george/Desktop/elastic"

function ans() {
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory-file "$base/hosts" --private-key "$base/sshkey.private" -u root "$@"
}

ans setup-k3s-ansible/common.playbook
ans elastic.playbook
