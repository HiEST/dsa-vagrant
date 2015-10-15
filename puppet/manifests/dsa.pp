exec {'extract-dsa':
  cwd     => "/opt/dsa",
  command => "tar xzf /vagrant/puppet/files/dsa/dsa.standalone.Ubuntu.14.04.3.tar.gz",
  path    => "/usr/local/bin/:/usr/bin:/bin/",
  user    => 'vagrant',
  timeout => 0,
  require => [ File['/opt/dsa'] ],
} 

exec { "compile-dsa-kernel":
   cwd     => "/opt/dsa/dsa/kernel",
   command => "make",
   path    => "/usr/local/bin/:/usr/bin:/bin/",
   user    => 'vagrant',
   require => [ Package['automake','gcc', 'libtool', 'libibverbs-dev', 'librdmacm-dev'], Exec['extract-dsa'] ],
   timeout => 0,
   unless => "ls /opt/dsa/dsa/kernel/*.ko",
}

exec { "modprobes":
   command => "sh /vagrant/puppet/scripts/modprobes.sh",
   path    => "/usr/local/bin/:/usr/bin:/bin/:/sbin/",
   user    => 'root',
   unless => "lsmod | /bin/grep siw",
   require => [Package['ibverbs-utils','rdmacm-utils','libibverbs-dev','librdmacm-dev',"linux-image-extra-$kernelrelease"]],
}

exec{ "dsa.ko":
   command => "insmod /opt/dsa/dsa/kernel/dsa.ko",
   path    => "/usr/local/bin/:/usr/bin:/bin/:/sbin/",
   unless => "lsmod | /bin/grep dsa",
   user    => 'root',
   require => [Exec['modprobes', 'compile-dsa-kernel']]
} 

exec{ "saltest.ko":
   command => "insmod /opt/dsa/dsa/kernel/saltest.ko",
   path    => "/usr/local/bin/:/usr/bin:/bin/:/sbin/",
   unless => "lsmod | /bin/grep saltest",
   user    => 'root',
   require => [Exec['dsa.ko']]
} 


exec{ "create_partition":
  command => "echo 'device new berlin' > /sys/class/iomem/test_device/ctrl_if; echo 'partition new berlin 2 80960000' > /sys/class/iomem/test_device/ctrl_if",
  user    => 'root',
  unless  => 'find /sys/class/iomem/berlin/ | grep partitions | grep f0',
  require => [Exec['saltest.ko'], Package['tree']]
}


