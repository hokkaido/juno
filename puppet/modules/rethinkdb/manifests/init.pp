class rethinkdb (
  $repository = 'ppa:rethinkdb/unstable',
  $package = 'rethinkdb',
  $version = 'present'
) {

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  class { 'apt': }

  anchor { 'rethinkdb::begin:': }
  ->
  apt::ppa { $repository : }
  ->
  package { $package:
    ensure => $version,
    require => Exec['apt-get update']
  }
  ->
  class { 'rethinkdb::config': }
  -> anchor { 'rethinkdb::end': }

}




