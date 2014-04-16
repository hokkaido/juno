class juno (

) {



  file { '/home/vagrant/juno/project.clj':
     ensure => 'link',
     target => '/vagrant/project.clj',
  }

  file { '/home/vagrant/juno/checkouts/juno-core':
     ensure => 'link',
     target => '/vagrant/juno-core',
  }

  file { '/home/vagrant/juno/checkouts/juno-app':
     ensure => 'link',
     target => '/vagrant/juno-app',
  }

}
