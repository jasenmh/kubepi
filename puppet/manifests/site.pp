node default {
  include nfs-common
  include ssh_users

  if $trusted['hostname'] ~= /^server/ {
    include ntfs
    include nfs-server
  }
}
