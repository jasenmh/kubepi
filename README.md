# kubepi
Raspberry Pi Kubernetes cluster, with enough configuration mgmt to keep me
sane.

## puppet
This requires that the puppet agent already be installed. To use this 
masterless puppet repo, 

```sh
$ cd puppet
$ puppet apply --modulepath ./modules manifests/site.pp
```

Machines with a hostname containing the string **server** will be configured
as Kubernetes server nodes, otherwise they will be setup as worker nodes.

## k8s
Kubernetes configuration files.

## scripts
These scripts are used to make the k8s nodes.

## references
I try to keep a list of all the sources I use while setting up this cluster.
