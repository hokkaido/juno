class { 'rethinkdb':
	repository => 'ppa:rethinkdb/unstable'
}

class { 'golang' :
  version => '1.2.1'
}