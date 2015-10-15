file { '/home/vagrant/downloads/':
  ensure => 'directory',
}

file { '/opt/dsa':
  owner    => 'vagrant',
  group    => 'vagrant',
  ensure => 'directory',
}


file { '/etc/libibverbs.d':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
}

file { '/etc/security/limits.d/vagrant.conf':
  ensure => present,
  source => '/vagrant/puppet/templates/limits.conf',
}

file { '/opt/applications':
  ensure => 'directory',
  owner  => 'vagrant',
  group  => 'vagrant',
}

file { '/etc/libibverbs.d/dsa.driver':
          ensure => present,
          source => "/usr/local/etc/libibverbs.d/dsa.driver",
          require => [ File['/etc/libibverbs.d'], Exec['compile-dsa-userlib'] ]
}

file { '/data':
         ensure => directory,
}

