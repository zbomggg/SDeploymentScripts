#To install the kilo version of swift
#should be run on a newly installed ubuntu14.04 server
source localrc.sh
source conf_func.sh

sudo cp $base_dir/sources.list-sample /etc/apt/sources.list
sudo sed -i "s/repo_server/$repo_server/g" /etc/apt/sources.list

apt-get install ubuntu-cloud-keyring

sudo apt-get update
sudo apt-get dist-upgrade -y --force-yes

# install the proxy server
sudo apt-get install -y --force-yes swift swift-proxy python-swiftclient memcached

echo "please check"
read aaaaa

cp $base_dir/proxy-server.conf-sample $base_dir/proxy-server.conf
SetKey DEFAULT swift_dir /etc/swift $base_dir/proxy-server.conf
SetKey DEFAULT user swift $base_dir/proxy-server.conf
SetKey app:proxy-server account_autocreate true $base_dir/proxy-server.conf
SetKey filter:cache memcache_servers 127.0.0.1:11211 $base_dir/proxy-server.conf

sudo mkdir /etc/swift
sudo mv $base_dir/proxy-server.conf /etc/swift/proxy-server.conf

echo "please check"
read aaaaa

# install the storage server
sudo apt-get install -y xfsprogs rsync
for dev in ${devices[@]}
do
    sudo umount /dev/cciss/${dev}
    sudo mkfs.xfs -f /dev/cciss/${dev}
    sudo mkdir -p /srv/node/${dev}
    sudo sed -i "/\/srv\/node\/${dev}/d" /etc/fstab
    echo "/dev/cciss/${dev} /srv/node/${dev} xfs noatime,nodiratime,nobarrier,logbufs=8 0 2" | sudo tee -a /etc/fstab
    sudo mount /srv/node/${dev}
done

echo "please check /etc/fstab"
read aaaaa

sudo cp $base_dir/rsyncd.conf-sample /etc/rsyncd.conf
sudo sed -i "5c address=$primary_ip" /etc/rsyncd.conf
sudo sed -i "8c RSYNC_ENABLE=true" /etc/default/rsync

echo "please check rsyncd.conf"
read aaaaa

sudo apt-get -y --force-yes install swift swift-account swift-container swift-object

echo "please check"
read aaaaa

cp $base_dir/account-server.conf-sample $base_dir/account-server.conf
SetKey DEFAULT bind_ip $primary_ip $base_dir/account-server.conf
SetKey DEFAULT user swift $base_dir/account-server.conf
SetKey DEFAULT swift_dir /etc/swift $base_dir/account-server.conf
SetKey DEFAULT devices /srv/node $base_dir/account-server.conf
SetKey filter:recon recon_cache_path /var/cache/swift $base_dir/account-server.conf
sudo mv $base_dir/account-server.conf /etc/swift/account-server.conf

cp $base_dir/container-server.conf-sample $base_dir/container-server.conf
SetKey DEFAULT bind_ip $primary_ip $base_dir/container-server.conf
SetKey DEFAULT user swift $base_dir/container-server.conf
SetKey DEFAULT swift_dir /etc/swift $base_dir/container-server.conf
SetKey DEFAULT devices /srv/node $base_dir/container-server.conf
SetKey filter:recon recon_cache_path /var/cache/swift $base_dir/container-server.conf
sudo mv $base_dir/container-server.conf /etc/swift/container-server.conf

cp $base_dir/object-server.conf-sample $base_dir/object-server.conf
SetKey DEFAULT bind_ip $primary_ip $base_dir/object-server.conf
SetKey DEFAULT user swift $base_dir/object-server.conf
SetKey DEFAULT swift_dir /etc/swift $base_dir/object-server.conf
SetKey DEFAULT devices /srv/node $base_dir/object-server.conf
SetKey filter:recon recon_lock_path /var/lock $base_dir/object-server.conf
SetKey filter:recon recon_cache_path /var/cache/swift $base_dir/object-server.conf
sudo mv $base_dir/object-server.conf /etc/swift/object-server.conf

sudo chown -R swift:swift /srv/node
sudo mkdir -p /var/cache/swift
sudo chown -R swift:swift /var/cache/swift

#Create the rings
# sudo $base_dir/create_ring.sh
sudo $base_dir/pull_rings.sh

echo "please check the rings"
read aaaaa

#Finalize installation
cp $base_dir/swift.conf-sample $base_dir/swift.conf
ModKey "swift-hash" swift_hash_path_suffix $hash_path_suffix $base_dir/swift.conf
ModKey "swift-hash" swift_hash_path_prefix $hash_path_prefix $base_dir/swift.conf
sudo mv $base_dir/swift.conf /etc/swift/swift.conf

echo "please check swift.conf"
read aaaaa

sudo chown -R swift:swift /etc/swift
sudo service memcached restart
sudo service swift-proxy restart
sudo swift-init all start