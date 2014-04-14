class leiningen (
  $user  = 'vagrant',
  $group = 'vagrant',
  $url   = 'https://raw.github.com/technomancy/leiningen/stable/bin/lein'
) {

  class { 'java': }

  package { "wget":
    ensure => present,
  }

  file { "create local-bin-folder":
    ensure => directory,
    path   => "/home/${user}/bin",
    owner  => $user,
    group  => $group,
    mode   => '755',
  }

  exec { "download leiningen":
    user    => $user,
    group   => $user,
    path    => ["/bin", "/usr/bin", "/usr/local/bin"],
    cwd     => "/home/${user}/bin",
    command => "wget ${url} && chmod 755 lein",
    creates => "/home/$user/bin/lein",
    require => [File["create local-bin-folder"],
                Package["wget"]],
  }

  exec {'exec_coolness':
    command => "/home/${user}/bin/lein",
    creates => "/home/${user}/.lein",
    require => Exec["download leiningen"]
  }



}
