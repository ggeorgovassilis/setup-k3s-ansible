# setup-k3s-ansible
Ansible playbook that sets up a k3s cluster and an Elasticsearch cluster on top. Some assumptions:
- 1 master, 3 worker nodes (just remove or add worker nodes from the hosts file if you need a different number of worker nodes)
- Tested with VMs running CentOS 8 and CentOS 9 stream
- VMs have a public and a private network interface. If not, just replace the "private_ip" and "private_interface" values from the host file with the VM's public IP and network interface.
- SSH keys have been installed on VMs

# Create VMs
I'm assuming we'll use VMs here, bare metal servers will work as well. CentOS is already installed on the servers and your public SSH key has been uploaded. Many VPS hosters allow submitting a key during creation, if not, follow [these instructions](http://www.linuxproblem.org/art_9.html). It's important that the key is installed on all servers. Make sure that TCP port 22 is accessible and that there is no firewall between the private network interfaces. The setup is flexible, you can add or remove worker nodes as needed. Also, make sure you've logged in at least once with ssh to the VMs before running the playbook so that the ssh client doesn't ask for any confirmations, or alternatively set an environment variable "ANSIBLE_HOST_KEY_CHECKING=False".

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

# Run the playbooks
First we need to set up the VMs with a few dependencies and install k3s on it. This is not specific to Elasticsearch and only installs k3s.

```
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory-file "hosts" --private-key "sshkey.private" -u root setup-k3s.playbook
```

where "sshkey.pivate" points to the private part of the ssh key you installed in the VMs. "-u root" means to login as a root user, if you have a different ssh user, specify that here. "--inventory-file hosts" tells ansible to use the "hosts" file we edited earlier. 

After that is done, run the second playbookt which installs the Elastic operator and then an Elastic cluster:

```
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory-file "hosts" --private-key "sshkey.private" -u root setup-elastic.playbook
```

# Useful commands to check health and status
```
kubectl get nodes
kubectl cluster-info
kubectl get namespaces
kubectl get endpoints -n kube-system
kubectl get pods -n kube-system
kubectl describe nodes
kubectl -n elastic-system logs -f statefulset.apps/elastic-operator
kubectl get pods -o wide
kubectl get elasticsearch
```

# Caveats
The playbooks are not good at detecting if a task is necessary and they may fail if executed repeatedly on the same VM. If you need to run a playbook again, it's best to
wipe the VM first.


# Acknowledgements

Instructions for setting up k3s were taken from [Install Kubernetes using k3s on CentOS 9|RHEL 9|AlmaLinux 9](https://technixleo.com/install-kubernetes-k3s-on-centos-rhel-alma/) by Ann Kamu.

Instructions for setting up Elastic on Kubernetes were taken from [Deploy ECK in your Kubernetes cluster](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html)
