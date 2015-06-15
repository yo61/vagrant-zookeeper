# zookeeper config
class zookeeper::config(
  $datadir,
){

  # define the config

  # initialize if not done already
  exec{'initialize_zookeeper':
    command => '/etc/init.d/zookeeper-server init',
    creates => "${datadir}/version-2",
    path    => [
      '/usr/local/sbin',
      '/sbin',
      '/bin',
      '/usr/sbin',
      '/usr/bin',
    ],
  }

}
