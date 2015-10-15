exec { 'apt-get update':
  path => '/usr/bin'
}

#package { ['linux-image-generic-lts-trusty']:
#  ensure => present,
#  before => Exec['apt-get update']
#}


package { ['curl', 'unzip', 'vim', 'make', 'gcc', 'g++', 'automake', 'libtool', 'libibverbs-dev', 'librdmacm-dev', 'ibverbs-utils', "linux-headers-$kernelrelease", 'rdmacm-utils','libibcm1', 'tree', "linux-image-extra-$kernelrelease"]:
  ensure => present,
  require => Exec['apt-get update']
}


