# kubepi
Raspberry Pi Kubernetes cluster, with enough configuration mgmt to keep me
sane.

## puppet
This requires that the puppet agent already be installed. To use this 
masterless puppet repo, 

```bash
$ cd puppet
$ puppet apply --modulepath ./modules manifests/site.pp
```

Machines with a hostname containing the string **server** will be configured
as Kubernetes server nodes, otherwise they will be setup as worker nodes.

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

## scripts
These scripts are used to make the k8s nodes.

## references
I try to keep a list of all the sources I use while setting up this cluster.
