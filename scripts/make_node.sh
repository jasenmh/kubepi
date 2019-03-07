#!/bin/sh

if [ $# -ne 3 ]; then
  echo "syntax: make_node.sh <hostname> <ip_address> <dns_ip_address>"
  exit 1
fi

hostname=$1
ip=$2
dns=$3

hostname_and_ip.sh "$hostname" "$ip" "$dns"

if [ $? -ne 0 ]; then
  echo "error: hostname_and_ip.sh exited with code $?"
  exit 1
fi

install_k8s.sh

if [ $? -ne 0 ]; then
  echo "error: install_k8s.sh exited with code $?"
  exit 1
fi

wget https://apt.puppetlabs.com/puppet-release-stretch.deb
sudo dpkg -i puppet-release-stretch.deb
sudo apt-get update
sudo apt-get install puppet -y

git checkout https://github.com/jasenmh/kubepi.git
cd kubepi/puppet
puppet apply --modulepath ./modules manifests/site.pp

if [ $? -ne 0 ]; then
  echo "error: puppet apply exited with code $?"
else
  echo "make_node.sh complete -- rebooting"
  sudo reboot
fi

