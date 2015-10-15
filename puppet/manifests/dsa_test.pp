exec { "compile-dsa-tests":
   cwd     => "/opt/dsa/dsa/tests",
   command => "make",
   path    => "/usr/local/bin/:/usr/bin:/bin/",
   user    => 'vagrant',
   require => [ Package['automake','gcc', 'libtool', 'libibverbs-dev', 'librdmacm-dev'], Exec['install-dsa-userlib'] ],
   timeout => 0
}
