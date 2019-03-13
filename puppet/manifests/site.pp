node default {
  include nfs_common
  include ssh_users

  if $hostname =~ /^server/ {
    include ntfs
    include nfs_server
  }
}
