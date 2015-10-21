exec { 'apt-get update':
  path => '/usr/bin'
}

apt::source { 'ompss-repository':
  comment  => 'BSC PM repository',
  location => 'http://pm.bsc.es/ompss/packages/debian',
  release  => 'wheezy',
  repos    => 'main',
  require => Exec['omps-pgp'],
  before  => Exec['apt-get update']
}

exec { "omps-pgp":
   cwd     => "/tmp",
   command => "wget -O - http://pm.bsc.es/ompss/packages/debian/ompss.gpg.key | apt-key add -",
   path    => "/usr/local/bin/:/usr/bin:/bin/",
   user    => 'root',
   timeout => 0
}

#unless => "grep /etc/apt/sources.list.d/",

package { ['curl', 'unzip', 'vim', 'make', 'gcc', 'g++', 'automake', 'libtool', 'libibverbs-dev', 'librdmacm-dev', 'ibverbs-utils', "linux-headers-$kernelrelease", 'rdmacm-utils','libibcm1', 'tree', "linux-image-extra-$kernelrelease", 'ompss']:
  ensure => present,
  require => Exec['apt-get update']
}


