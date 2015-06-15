# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
  # Download + install Puppet modules from the forge inside the machine
  # uses librarian-puppet so needs ruby 1.9.3
  # Oh, ruby, ruby.. ಠ_ಠ
  if [ ! -f /opt/rh/ruby193/root/usr/local/bin/librarian-puppet ]; then
    echo "Initial provisioning.  This takes a while, be patient"
    sudo yum -y -q install centos-release-SCL
    sudo yum -y -q install ruby193 ruby193-ruby-devel gcc tar git dstat
    sudo scl enable ruby193 "gem install --no-ri --no-rdoc librarian-puppet"
    echo '¯\\_(ツ)_/¯'
  fi
  cd /vagrant/puppet
  scl enable ruby193 "/opt/rh/ruby193/root/usr/local/bin/librarian-puppet install"
  # turn off the firewall to make life easier
  service iptables stop
  chkconfig iptables off
SCRIPT

VAGRANTFILE_API_VERSION = "2"
CENTOS = {
    box: "puppetlabs/centos-6.6-64-puppet"
}
NODE_COUNT = ENV["ZK_NODE_COUNT"].nil? ? 3 : ENV["ZK_NODE_COUNT"].to_i
OS         = ENV["ZK_OS"].nil? ? CENTOS : Kernel.const_get(ENV["ZK_OS"])

Vagrant.configure(VAGRANTFILE_API_VERSION) do |cluster|

  (1..NODE_COUNT).each do |index|
    last_octet = index + 101
    nodename = 'zk' + sprintf("%02d", index)

    cluster.vm.define nodename.to_sym do |config|
      config.vm.box = OS[:box]

      config.vm.provider :virtualbox do |vb, override|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
      end

      config.vm.hostname = nodename
      config.vm.network :private_network, ip: "10.10.10.#{last_octet}"

      # Deploy puppet modules on the node
      config.vm.provision :shell, inline: $script

      config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.module_path = ["puppet/localmodules", "puppet/modules"]
        puppet.working_directory = "/vagrant/puppet"
        puppet.manifest_file = "site.pp"
        puppet.hiera_config_path = 'puppet/hiera.yaml'
        #puppet.options = ["--parser=future"]
        puppet.facter = {
          'envname' => 'vagrant',
          'role'    => 'zookeeper',
        }
      end
    end
  end

end
