# configure hosts file for our internal network defined by Vagrantfile
#cat >> /etc/hosts <<-EOL
## vagrant environment nodes
#192.168.56.2  Web1.demo.com
#192.168.56.3  Web2.demo.com
#192.168.56.4  ansible-host

cat << EOF >> /etc/hosts
# vagrant environment nodes
192.168.56.2  host1
192.168.56.3  host2
192.168.56.4  ansible-host
EOF
