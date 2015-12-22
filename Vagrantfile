
Vagrant.configure('2') do |config|
  config.ssh.insert_key = false
  config.vm.box = 'centos7.1'
  config.vm.network :private_network, ip: '192.168.33.18', netmask: '255.255.255.0'
  config.vm.synced_folder '.', '/etc/puppetlabs/code/modules/spacewalk'
  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--memory', 1024]
  end
end
