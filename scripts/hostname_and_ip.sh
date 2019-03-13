#!/bin/sh

hostname=$1
ip=$2
router=$3
dns=$4

failed=0

check_failure()
{
  if [ $? -ne 0 ]; then
    failed=1
  fi
}

# Change hostname
sudo hostnamectl --transient set-hostname $hostname
check_failure
sudo hostnamectl --static set-hostname $hostname
check_failure
sudo hostnamectl --pretty set-hostname $hostname
check_failure
sudo sed -i s/raspberrypi/$hostname/g /etc/hosts
check_failure

# Set static IP (performing manually)

#sudo cat <<EOT >> /etc/dhcpcd.conf
#interface eth0
#static ip_address=$ip/24
#static routers=$router
#static domain_name_servers=$dns
#EOT

#check_failure

if [ $failed -eq 1 ]; then
  echo "$0 error: not all commands succeeded"
  exit 1
fi

echo "hostname and ip info set"
exit 0
