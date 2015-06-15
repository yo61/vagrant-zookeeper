# set up zookeeper
class profile_zookeeper{

  class{'::java':}->
  class{'::zookeeper':
    repo                 => 'cloudera',
    servers              => hiera_array('zk_servers'),
    packages             => ['zookeeper', 'zookeeper-server'],
    client_ip            => $::ipaddress_eth1,
    service_name         => 'zookeeper-server',
    initialize_datastore => true
  }

}