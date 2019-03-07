class nfs-common {

  package { 'nfs-common':
    ensure   => present,
    provider => apt,
  }

}
