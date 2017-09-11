sudo yum install git gettext wget -y
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
sudo rpm -ivh epel-release-7-10.noarch.rpm
sudo yum install python-setuptools python-pip python-wheel openssl-devel python-devel gcc gcc-c++ python-docker-py -y
sudo pip install ansible
# get docker from official repos
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum install -y docker-ce
sudo systemctl enable docker
sudo systemctl start docker
#install node from source
wget https://nodejs.org/dist/v6.11.3/node-v6.11.3.tar.gz
tar xzvf node-v* && cd node-v*
./configure
make -j4
sudo make install
cd
sudo pip install docker-py --upgrade
sudo usermod -a -G docker vagrant
exit

# must install node from source, so amend the above
# maybe start docker, then fix perms for current user
