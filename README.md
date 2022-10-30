# setup-k3s-ansible
Scripts that setup a k3s cluster with ansible. Some assumptions:
- 1 master, 3 worker nodes
- VMs with CentOS 9 stream
- VMs have a public and a private network interface
- SSH keys have been installed on VMs

# Create VMs
I'm assuming we'll use VMs here, bare metal servers will work as well. CentOS 9 is already installed on the servers and your public SSH key has been uploaded. Many VPS hosters allow submitting a key during creation, if not, follow [these instructions](http://www.linuxproblem.org/art_9.html). It's important that the key is installed on all servers. Make sure that TCP port 22 is accessible and that there is no firewall on the private network interfaces. The setup is flexible, you can add or remove worker nodes as needed. Also, make sure you've logged in at least once with ssh to the VMs before running the playbook so that the ssh client doesn't ask for any confirmations.

~~~~
  +---+   +---+    +----------+
  | I |   | F |----| emaster  |--+
  | n |   | i |    +----------+  |
  | t |   | r |----| eworker1 |--+
  | e |---| e |    +----------+  |
  | r |   | w |----| eworker2 |--+
  | n |   | a |    +----------+  |
  | e |   | l |----| eworker3 |--+
  | t |   | l |    +----------+
  +---+   +---+    
~~~~  
  
# Edit hosts
Edit the "hosts" file, editing the server names, public IPs and private IPs to reflect your setup.

# Install ansible
Install ansible on your computer. Each OS has a different method for doing this, on my Ubuntu it's

```
sudo apt install ansible
```

# Run the playbook
Run

```
ansible-playbook --inventory-file "hosts" --private-key "sshkey.private" -u root
```

where "sshkey.pivate" points to the private part of the ssh key you installed in the VMs. "-u root" means to login as a root user, if you have a different ssh user, specify that here. "--inventory-file hosts" tells ansible to use the "hosts" file we edited earlier.
