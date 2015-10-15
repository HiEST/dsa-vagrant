class { 'python' :
    version    => 'system',
    pip        => true,
    dev        => true,
    virtualenv => true,
    gunicorn   => false    
}

