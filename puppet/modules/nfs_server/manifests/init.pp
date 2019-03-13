class nfs_server {

  package { 'nfs-server':
    ensure   => present,
    provider => apt,
  }

}
