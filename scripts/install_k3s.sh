#!/bin/sh

failed=0

check_failure()
{
  if [ $? -ne 0 ]; then
    failed=1
  fi
}

# Disable swap
#sudo dphys-swapfile swapoff && \
#sudo dphys-swapfile uninstall && \
#sudo update-rc.d dphys-swapfile remove
#check_failure

echo Adding " cgroup_enable=cpuset cgroup_enable=memory" to /boot/cmdline.txt
sudo cp /boot/cmdline.txt /boot/cmdline_backup.txt
orig="$(head -n1 /boot/cmdline.txt) cgroup_enable=cpuset cgroup_enable=memory"
echo $orig | sudo tee /boot/cmdline.txt
#check_failure

# Download/install k3s
wget https://github.com/rancher/k3s/releases/download/v0.2.0/k3s-armhf && \
chmod +x k3s-armhf && \
sudo mv k3s-armhf /usr/local/bin/k3s

check_failure

cd ~
git clone https://github.com/rancher/k3s.git
sudo mv k3s/k3s.service /lib/systemd/system
cd -
sudo systemctl daemon-reload
sudo systemctl enable k3s

check_failure

if [ $failed -eq 1 ]; then
  echo "$0 error: some command failed"
  exit 1
fi

echo "k3s installed"
exit 0
