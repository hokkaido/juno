class java (
  $version = 'jdk1.7.0_55',
  $url = 'http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.tar.gz',
  $archive_name = 'jdk-7u55-linux-x64.tar.gz',
  $install_dir = '/usr/lib/jdk',
  $download_dir = '/tmp'


) {

  package { "wget":
    ensure => present,
  }
  
  exec { "download java":
    user    => 'root',
    path    => ["/bin", "/usr/bin", "/usr/local/bin"],
    cwd     => "${download_dir}",
    command => "wget --no-cookies --no-check-certificate --header \"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com\" --header \"Cookie: oraclelicense=accept-securebackup-cookie\" \"${url}\"",
    creates => "${download_dir}/${archive_name}",
    require => Package["wget"],
  }

  file { "create installation directory":
    ensure => directory,
    path   => "${install_dir}",
    owner  => 'root',
    group  => 'root',
    mode   => '755',
  }

  exec { "extract archive":
    user    => 'root',
    path    => ["/bin", "/usr/bin", "/usr/local/bin"],
    command => "tar zxvf ${download_dir}/${archive_name} -C ${install_dir}",
    creates => "${install_dir}/${version}",
    require => [Exec["download java"], File["create installation directory"]],
  }

   exec { "update defaults":
    user    => 'root',
    path    => ["/bin", "/usr/bin", "/usr/local/bin"],
    command => "update-alternatives --install \"/usr/bin/java\" \"java\" \"${install_dir}/${version}/bin/java\" 1 && update-alternatives --set java ${install_dir}/${version}/bin/java",
    require => Exec["extract archive"],
  }
  
  
  
}