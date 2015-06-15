# install zookeeper
class zookeeper(
  $datadir = $::zookeeper::params::datadir,
) inherits ::zookeeper::params {

  anchor{'zookeeper_first':}->
  class{'::zookeeper::install':}->
  class{'::zookeeper::config':
    datadir => $datadir
  }~>
  class{'::zookeeper::service':}->
  anchor{'zookeeper_last':}

}