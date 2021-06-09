class nis::config (
  $domain = $nis::domain,
  $broadcast = $nis::broadcast,
  $servers = $nis::servers,
  $package = $nis::package,
  $rebind_interval = $nis::rebind_interval,
  ) {

    file { '/etc/yp.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('nis/yp.conf.erb'),
      require => Package[$package],
    }

    file {'/etc/sysconfig/ypbind':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "-r ${rebind_interval}",
      notify  => Service['ypind'],
    }
  }
