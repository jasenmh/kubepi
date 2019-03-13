# kubepi
Raspberry Pi Kubernetes cluster, with enough configuration mgmt to keep me
sane.

## Raspberry Pi image
I started with the current, stock Stretch-lite. On boot, I changed the `pi` 
password and ran `rasp-config` to set region info.

Once I started each node, I configured and installed the rest via the 
`make_node.sh` script.

## scripts
These scripts are used to make the k3s nodes: setting up hostnames, ip
address info, installing k3s, and some infrastructure
packages to share media across the nodes.

```bash
$ cd scripts
$ ./make_node.sh <hostname> <ip_addr> <router_addr> <dns_addr>
```

## k3s
Steps to setup k3s on nodes:

## puppet
This requires that the puppet agent already be installed. To use this 
masterless puppet repo, 

```bash
$ cd puppet
$ puppet apply --modulepath ./modules manifests/site.pp
```

Machines with a hostname that start with the string **server** will be 
configured as Kubernetes server nodes, otherwise they will be setup as worker 
nodes.

This gets applied by the `make_node.sh` script above.

## references
I try to keep a list of all the sources I use while setting up this cluster.
