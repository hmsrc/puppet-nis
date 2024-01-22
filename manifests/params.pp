class nis::params {
  case $::osfamily {
    'RedHat': {
      $package = 'ypbind'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $domain          = 'nis'
  $broadcast       = false
  $servers         = []
  $rebind_interval = 900
  $ping_interval   = 20
  $ypbind_debug    = false
  $ypbind_verbose  = false
}
