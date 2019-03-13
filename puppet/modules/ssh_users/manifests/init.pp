class ssh_users {

  file { '/home/pi/.ssh':
    ensure => directory,
    owner  => pi,
    group  => pi,
    mode   => "0700",
  }

  file { '/home/pi/.ssh/authorized_keys':
    ensure  => present,
    owner   => pi,
    group   => pi,
    mode    => "0700",
    source  => 'puppet:///modules/ssh_users/authorized_keys',
    require => File['/home/pi/.ssh'],
  }

}
