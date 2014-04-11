class golang::params { 

  $version =         '1.2.1'
  $remove_previous = true
  $arch =            "${architecture}"
  $install_dir =     '/usr/local'
  $download_dir =    '/tmp'
  $cleanup =         true
  $workspace =       '/home/vagrant/go'
  $profile =         '/home/vagrant/.profile'
  $user =            'vagrant'
  $group =           'vagrant'

  case $::osfamily { 
    'Debian': {
      $archive_name = "go${version}.linux-${arch}.tar.gz"
  	  $url = "https://go.googlecode.com/files/${archive_name}"
 	  }
  }  
}