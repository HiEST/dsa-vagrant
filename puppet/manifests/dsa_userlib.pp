exec { "compile-dsa-userlib":
   cwd     => "/opt/dsa/dsa/userlib",
   command => "./autogen.sh && ./autogen.sh && ./configure && make",
   path    => "/usr/local/bin/:/usr/bin:/bin/",
   user    => 'vagrant',
   require => [ Package['automake','gcc', 'libtool', 'libibverbs-dev', 'librdmacm-dev'], Exec['saltest.ko'] ],
   timeout => 0,
   unless => "ls /opt/dsa/dsa/kernel/*.ko",
}

exec { "install-dsa-userlib":
   cwd     => "/opt/dsa/dsa/userlib",
   command => "make install",
   path    => "/usr/local/bin/:/usr/bin:/bin/:/sbin/",
   user    => 'root',
   unless => "lsmod | /bin/grep siw",
   require => [ Exec['compile-dsa-userlib'] ]
}


exec{ "dsa.ldconfig":
   command => "/sbin/ldconfig",
   path    => "/usr/local/bin/:/usr/bin:/bin/:/sbin/",
   require => [Exec['dsa.ko','install-dsa-userlib'], File['/etc/libibverbs.d/dsa.driver']]
}
