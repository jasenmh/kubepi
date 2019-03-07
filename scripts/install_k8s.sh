#!/bin/sh

failed=0

check_failure()
{
  if [ $? -ne 0 ]; then
    failed=1
  fi
}

# Install Docker
curl -sSL get.docker.com | sh && \
sudo usermod pi -aG docker
check_failure

# Disable swap
sudo dphys-swapfile swapoff && \
sudo dphys-swapfile uninstall && \
sudo update-rc.d dphys-swapfile remove
check_failure
echo Adding " cgroup_enable=cpuset cgroup_enable=memory" to /boot/cmdline.txt
sudo cp /boot/cmdline.txt /boot/cmdline_backup.txt
orig="$(head -n1 /boot/cmdline.txt) cgroup_enable=cpuset cgroup_enable=memory"
echo $orig | sudo tee /boot/cmdline.txt
check_failure

# Add repo list and install kubeadm
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
sudo apt-get update -q && \
sudo apt-get install -qy kubeadm
check_failure

if [ $failed -eq 1 ]; then
  echo "$0 error: some command failed"
  exit 1
fi

echo "swap disabled, docker and k8s installed"
exit 0
