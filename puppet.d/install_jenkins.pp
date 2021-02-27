class jenkins {

    # get key
    exec { 'install_jenkins_key':
        command => '/usr/bin/wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -',
    }

        # source file
    file { '/etc/apt/sources.list.d/jenkins.list':
        content => "deb https://pkg.jenkins.io/debian-stable binary/\n",
        ensure => present,
        mode    => '0644',
        owner   => root,
        group   => root,
        require => Exec['install_jenkins_key'],
    } -> 

    # update
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update',
    }

    #install jenkins
    $enhancers = [ 'openjdk-8-jre', 'jenkins' ]

    package { $enhancers:
        ensure => 'installed',
    } ->
    # systemctl daemon-reload
    exec { 'reload-systemctl':
        command => '/bin/systemctl daemon-reload',
    }

    # verify jenkins is running
    service { 'jenkins':
        ensure  => running,
        enable  => "true",
        require => Exec['reload-systemctl']
    }
}
