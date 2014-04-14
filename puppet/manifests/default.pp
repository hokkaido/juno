class { 'rethinkdb':
	repository => 'ppa:rethinkdb/ppa'
}

class { 'golang' :
  version => '1.2.1'
}

class { "leiningen": }
