#!/bin/sh

if [ $# -ne 4 ]; then
  echo "syntax: make_node.sh <hostname> <ip_addr> <router_addr> <dns_addr>"
  exit 1
fi

hostname=$1
ip=$2
router=$3
dns=$4

hostname_and_ip.sh "$hostname" "$ip" "$router" "$dns"

if [ $? -ne 0 ]; then
  echo "error: hostname_and_ip.sh exited with code $?"
  exit 1
fi

wget https://apt.puppetlabs.com/puppet-release-stretch.deb
sudo dpkg -i puppet-release-stretch.deb
sudo apt-get update
sudo apt-get install puppet -y

sudo apt-get install git -y

git checkout https://github.com/jasenmh/kubepi.git
cd kubepi/puppet
puppet apply --modulepath ./modules manifests/site.pp

install_k3s.sh

if [ $? -ne 0 ]; then
  echo "error: install_k3s.sh exited with code $?"
  exit 1
fi

if [ $? -ne 0 ]; then
  echo "error: puppet apply exited with code $?"
else
  echo "make_node.sh complete -- rebooting"
  sudo reboot
fi

