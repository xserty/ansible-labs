# configure hosts file for our internal network defined by Vagrantfile
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/centos*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/centos*
