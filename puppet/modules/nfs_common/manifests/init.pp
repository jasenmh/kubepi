class nfs_common {

  package { 'nfs-common':
    ensure   => present,
    provider => apt,
  }

}
