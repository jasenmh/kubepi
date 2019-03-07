# kubepi
Raspberry Pi Kubernetes cluster, with enough configuration mgmt to keep me
sane.

## scripts
These scripts are used to make the k8s nodes: setting up hostnames, ip
address info, installing Docker and Kubernetes, and some infrastructure
packages to share media across the nodes.

```bash
$ cd scrips
$ ./make_node.sh <hostname> <ip_address> <dns_ip_address>
```

## k8s
Kubernetes configuration files.

On server node,

```bash
$ cd k8s
$ sudo kubeadm init --config kubeadm_conf.yaml
```

This will output the command to run on each worker node. Once that's been
done, on the server node,

```bash
$ kubectl apply -f “https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d ‘\n’)
```

to add the weave-net container network.

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
