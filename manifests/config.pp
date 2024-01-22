class nis::config (
  $domain = $nis::domain,
  $broadcast = $nis::broadcast,
  $servers = $nis::servers,
  $package = $nis::package,
  $rebind_interval = $nis::rebind_interval,
  $ping_interval = $nis::ping_interval,
  $debug_ypbind = $nis::debug_ypbind,
  $verbose_ypbind = $nis::verbose_ypbind
  ) {

    file { '/etc/yp.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('nis/yp.conf.erb'),
      require => Package[$package],
    }

    # assemble the ybind options.
    $file_content = "-i ${ping_interval} -r ${rebind_interval}"
    if $debug_ypbind == true {
      $file_content.gsub!(/$/, ' -d');
    }
    if $verbose_ypbind == true {
      s.gsub!(/$/, ' -v');
    }

    file {'/etc/sysconfig/ypbind':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => $file_content,
      notify  => Service['ypbind'],
    }
  }
