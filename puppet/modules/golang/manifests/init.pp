class golang ( 
  $version =         $golang::params::version,
  $arch =            $golang::params::arch,
  $remove_previous = $golang::params::remove_previous,
  $archive_name =    $golang::params::archive_name,
  $url =             $golang::params::url,
  $download_dir =    $golang::params::download_dir,
  $install_dir =     $golang::params::install_dir,
  $workspace =       $golang::params::workspace,
  $profile =         $golang::params::profile,
  $user =            $golang::params::user,
  $group =           $golang::params::group
) inherits golang::params {

  validate_bool($remove_previous)

  notify{"Go's archive name is: ${archive_name}": }

  notify{"Go download url is: ${url}": }

  exec { 'download archive' :
    command => "/usr/bin/wget -O ${download_dir}/${archive_name} ${url}"
  }

  exec { 'remove previous install' :
    command => "/bin/rm -r ${install_dir}",
    onlyif =>  "/usr/bin/test -d {install_dir}",
    before =>  Exec['extract archive']
  }

  exec { 'extract archive':
    command => "/bin/tar -C ${install_dir} -xzf ${download_dir}/${archive_name}",
    require => Exec['download archive']
  }

  file { 'setup workspace directory':
    path =>    $workspace,
    ensure =>  'directory',
    owner =>   $user,
    group =>   $group,
    require => Exec['extract archive']
  }

  file_line { 'export gopath':
    path =>    $profile,
    line =>    "export GOPATH=${workspace}",
    require => File['setup workspace directory']
  }

  file_line { 'export path':
    path =>    $profile,
    line =>    "export PATH=\$PATH:${install_dir}/go/bin:\$GOPATH/bin",
    require => File_line['export gopath']
  }

}