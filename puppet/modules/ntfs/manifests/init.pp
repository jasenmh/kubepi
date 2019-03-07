class ntfs {

  package { 'ntfs-3g':
    ensure   => present,
    provider => apt,
  }

}
