node default {
  include git
  include nfs-common

  if $trusted['hostname'] ~= /^server/ {
    include ntfs
    include nfs-server
  }
}
