class leiningen (
  $user    = 'vagrant',
  $group   = 'vagrant',
  $url     = 'https://raw.github.com/technomancy/leiningen/stable/bin/lein',
  $profile = '/home/vagrant/.profile'
) {

  # package { "wget":
  #  ensure => present,
  # }

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
    creates => "/home/${user}/bin/lein",
    require => [File["create local-bin-folder"],
                Package["wget"]],
  }

  file_line { 'export path':
    path =>    $profile,
    line =>    "export PATH=\$PATH:/home/${user}/bin",
    require => Exec["download leiningen"]
  }



}
