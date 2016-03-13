#!/bin/bash

cd /etc/swift

rm -f *.builder *.ring.gz backups/*.builder backups/*.ring.gz

swift-ring-builder object.builder create 9 4 2
swift-ring-builder object.builder add r1z1-172.16.169.37:6000R192.168.5.12:6000/sdb 1
swift-ring-builder object.builder add r1z1-172.16.169.37:6000R192.168.5.12:6000/sdc 1
swift-ring-builder object.builder add r1z2-172.16.169.39:6000R192.168.5.14:6000/sdb 1
swift-ring-builder object.builder add r1z2-172.16.169.39:6000R192.168.5.14:6000/sdc 1
swift-ring-builder object.builder add r2z1-172.16.169.40:6000R192.168.5.15:6000/sdb 1
swift-ring-builder object.builder add r2z1-172.16.169.40:6000R192.168.5.15:6000/sdc 1
swift-ring-builder object.builder add r2z2-172.16.169.41:6000R192.168.5.16:6000/sdb 1
swift-ring-builder object.builder add r2z2-172.16.169.41:6000R192.168.5.16:6000/sdc 1
swift-ring-builder object.builder rebalance
swift-ring-builder container.builder create 9 4 2
swift-ring-builder container.builder add r1z1-172.16.169.37:6001R192.168.5.12:6001/sdb 1
swift-ring-builder container.builder add r1z1-172.16.169.37:6001R192.168.5.12:6001/sdc 1
swift-ring-builder container.builder add r1z2-172.16.169.39:6001R192.168.5.14:6001/sdb 1
swift-ring-builder container.builder add r1z2-172.16.169.39:6001R192.168.5.14:6001/sdc 1
swift-ring-builder container.builder add r2z1-172.16.169.40:6001R192.168.5.15:6001/sdb 1
swift-ring-builder container.builder add r2z1-172.16.169.40:6001R192.168.5.15:6001/sdc 1
swift-ring-builder container.builder add r2z2-172.16.169.41:6001R192.168.5.16:6001/sdb 1
swift-ring-builder container.builder add r2z2-172.16.169.41:6001R192.168.5.16:6001/sdc 1
swift-ring-builder container.builder rebalance
swift-ring-builder account.builder create 9 4 2
swift-ring-builder account.builder add r1z1-172.16.169.37:6002R192.168.5.12:6002/sdb 1
swift-ring-builder account.builder add r1z1-172.16.169.37:6002R192.168.5.12:6002/sdc 1
swift-ring-builder account.builder add r1z2-172.16.169.39:6002R192.168.5.14:6002/sdb 1
swift-ring-builder account.builder add r1z2-172.16.169.39:6002R192.168.5.14:6002/sdc 1
swift-ring-builder account.builder add r2z1-172.16.169.40:6002R192.168.5.15:6002/sdb 1
swift-ring-builder account.builder add r2z1-172.16.169.40:6002R192.168.5.15:6002/sdc 1
swift-ring-builder account.builder add r2z2-172.16.169.41:6002R192.168.5.16:6002/sdb 1
swift-ring-builder account.builder add r2z2-172.16.169.41:6002R192.168.5.16:6002/sdc 1
swift-ring-builder account.builder rebalance
