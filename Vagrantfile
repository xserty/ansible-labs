#
# https://github.com/mikecali/ansible-labs-101/blob/main/Vagrantfile
#

Vagrant.configure("2") do |config|

#  config.ssh.private_key_path = File.expand_path("~/.vagrant.d/insecure_private_keys/vagrant.key.ed25519", __FILE__)

# Define VMs with static private IP addresses, vcpu, memory and vagrant-box.
    boxes = [
        {
            :name => "host1",               # Host1 this is one of the target nodes
            :box => "generic-x64/centos9s", # OS version
            :ram => 1024,                   # Allocated memory
            :vcpu => 1,                     #  Allocated CPU
            :ip => "192.168.56.2"           # Allocated IP address of the node
        },
        {
            :name => "host2",               # Host2 this is one of the target nodes
            :box => "generic-x64/centos9s", # OS version
            :ram => 1024,
            :vcpu => 1,
            :ip => "192.168.56.3"
        },
        {
            :name => "ansible-host",         # Ansible Host with Ansible Engine
            :box => "generic-x64/centos9s",  # OS version
            :ram => 8048,
            :vcpu => 1,
            :ip => "192.168.56.4"
        }
    ]

    # Provision each of the VMs.
    boxes.each do |opts|
        config.vm.define opts[:name] do |config|
            # disable VirtualBox Guest Additions update
            if Vagrant.has_plugin?("vagrant-vbguest") then
                config.vbguest.auto_update = false
            end

            if Vagrant.has_plugin?("vagrant-proxyconf")
                config.proxy.http      = "http://proxyeurope.huawei.com:8080"
                config.proxy.https     = "https://proxyeurope.huawei.com:8080"
                config.proxy.no_proxy  = "localhost, 127.0.0.1"
            else
                raise Vagrant::Errors::VagrantError.new, "Plugin missing: vagrant-proxyconf. Host machine won't be able to connect to external network."
            end


            config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true, owner: "vagrant", mount_options: ["dmode=755,fmode=600"]
            config.ssh.insert_key = false
            config.vm.box_download_insecure=true
            config.vm.box = opts[:box]
            config.vm.hostname = opts[:name]
            config.vm.provider :virtualbox do |vb| #  Defines the vagrant provider
                vb.gui = true
                vb.memory = opts[:ram]
                vb.cpus = opts[:vcpu]
                vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
                vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
            end
            config.vm.network :private_network, ip: opts[:ip]
            config.vm.provision :file do |file|
                file.source     = './keys/vagrant' # vagrant keys to allow access to the nodes
                file.destination    = '/home/vagrant/.ssh/vagrant' # the location to copy the vagrant key
            end
            config.vm.provision :file do |file|
                file.source      = './inventory.yaml'
                file.destination = '/home/vagrant/inventory.yaml'
            end
            config.vm.provision :shell, path: "bootstrap-node.sh" # script that copy hosts entry
            config.vm.provision :shell, path: "profile-node.sh" # script that copy bash environments entries
            config.vm.provision :shell, path: "update-repo-node.sh" # script that copy bash environments entries
            config.vm.provision :ansible do |ansible| # declaration to run ansible playbook
                ansible.compatibility_mode = "2.0"
                ansible.verbose = "vvv"
                ansible.playbook = "playbook.yml" # the playbook used to configure the hosts
            end
        end # end internal config
    end # end opts
end # end external config
