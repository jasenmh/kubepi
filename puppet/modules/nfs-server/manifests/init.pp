class nfs-server {

  package { 'nfs-server':
    ensure   => present,
    provider => apt,
  }

}
