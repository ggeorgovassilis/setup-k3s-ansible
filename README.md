# setup-k3s-ansible
Scripts that setup a k3s cluster with ansible. Some assumptions:
- 1 master, 3 worker nodes
- VMs with CentOS 9 stream
- VMs have a public and a private network interface
- SSH keys have been installed on VMs

# Create VMs
I'm assuming we'll use VMs here, bare metal servers will work as well. CentOS 9 is already installed on the servers and your public SSH key has been uploaded. Many VPS hosters allow submitting a key during creation, if not, follow [these instructions](http://www.linuxproblem.org/art_9.html). It's important that the key is installed on all servers. Make sure that TCP port 22 is accessible and that there is no firewall on the private network interfaces.

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
  
