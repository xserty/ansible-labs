## Requirements:

* Internet connection is a must!
* Make sure the VT support is enabled in your BIOS
* Vagrant - 1.9.x or higher
* Vagrant plugins:
    - vagrant-proxyconf needed for running behind proxy
    - virtualbox_WSL2 needed for running under WSL
    - vagrant-vbguest automatically installs the host's VirtualBox Guest Additions
* Ansible: latest
* Virtualbox: latest


# Ansible Environment:

Multi-Machine Vagrant Environments:
This Vagrantfile will create 3 Centos VM's to simulate Ansible control machine and 2 target hosts.

* Host1 - No GUI
* Host2 - No GUI
* ansible-host - No GUI, ansible core installed and Ansible-tower


## WSL Environment Setup

Bash environment:
* export http_proxy=http://<your_proxy_server>:<port>
* export https_proxy=https://<your_proxy_server>:<port>


## VAGRANT Environment Setup

### VirtualBox settings needed for Vagrant
export VBOX_USER_HOME="/mnt/c/Users/<username>/.VirtualBox/"
export machinefolder="/mnt/c/Users/<username>/.VirtualBox/"
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export VAGRANT_HOME="~/.vagrant.d/"
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox" 
export VAGRANT_LOG=debug
set SSL_CERT_FILE=C:\My\App\Tools\HashiCorp\Vagrant\embedded\gems\gems\excon-0.99.0\data\cacert.pem


### Plugin Installation
Install (some plugins might need to be installed as user, not root to work):
* vagrant plugin install --plugin-clean-sources --plugin-source https://rubygems.org virtualbox_WSL2
* vagrant plugin install --plugin-clean-sources --plugin-source https://rubygems.org vagrant-vbguest
    - Might be necessary: vagrant plugin install --provider virtualbox --insecure vagrant-vbguest
* vagrant plugin install --plugin-clean-sources --plugin-source https://rubygems.org vagrant-proxyconf


### git setup

git config --global http.sslverify false


### Install requirements

ansible-galaxy install --ignore-certs  -r requirements.yml


## Files included:
- ansible.cfg
- inventory
- bootstrap-node.sh
- ansible-install.yaml
- playbook.yaml
- inventory.yaml

## Connecting the dots:
Before you run vagrant up, make sure that you updated the Vagrantfile to your desired configuration.
Specifically use the box that are available from https://atlas.hashicorp.com/boxes/.
The entry on the current vagrant file are Datacom specific boxes and is not available from atlas.

Once you are done:
- _vagrant up_
  Wait for about 6 minutes to finish the build. Once done. You can try to ssh to your ansible-host vm. You can verify this by using "_vagrant status_"

- _vagrant ssh ansible-host_
  once you are login to your ansible-host vm, you can now verify if the other vm are reachable. The command to use is: "_ansible-playbook -i inventory playbook/ping.yml_"
