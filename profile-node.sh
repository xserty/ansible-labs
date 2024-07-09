
# configure hosts file for our internal network defined by Vagrantfile
#cat >> ~/.bashrc <<-EOL
## proxy environment variables
#export http_proxy=http://proxyeurope.huawei.com:8080
#export https_proxy=http://proxyeurope.huawei.com:8080

cat << EOF >>  ~/.bashrc
export HTTP_PROXY=http://proxyeurope.huawei.com:8080
export HTTPS_PROXY=https://proxyeurope.huawei.com:8080
EOF
