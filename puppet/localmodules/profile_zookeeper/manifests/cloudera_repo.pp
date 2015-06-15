# install the cloudera repo
class profile_zookeeper::cloudera_repo{

  yumrepo{'cloudera_repo':
    name     => 'cloudera-cdh5',
    descr    => 'Cloudera\'s Distribution for Hadoop, Version 5',
    baseurl  => 'http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5/',
    gpgkey   => 'http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera',
    gpgcheck => true,
  }

}