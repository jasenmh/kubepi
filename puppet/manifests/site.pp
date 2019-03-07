node default {
  include nfs-common

  if $trusted['hostname'] ~= /^server/ {
    include ntfs
    include nfs-server
  }
}
