#!/bin/bash

cd /etc/swift

rm -f *.builder *.ring.gz backups/*.builder backups/*.ring.gz

swift-ring-builder object.builder create 9 4 2
swift-ring-builder object.builder add r1z1-10.64.3.37:6000/c0d1 1
swift-ring-builder object.builder add r1z1-10.64.3.37:6000/c0d2 1
swift-ring-builder object.builder add r1z2-10.64.3.39:6000/c0d1 1
swift-ring-builder object.builder add r1z2-10.64.3.39:6000/c0d2 1
swift-ring-builder object.builder add r2z1-10.64.3.40:6000/c0d1 1
swift-ring-builder object.builder add r2z1-10.64.3.40:6000/c0d2 1
swift-ring-builder object.builder add r2z2-10.64.3.41:6000/c0d1 1
swift-ring-builder object.builder add r2z2-10.64.3.41:6000/c0d2 1
swift-ring-builder object.builder rebalance
swift-ring-builder container.builder create 9 4 2
swift-ring-builder container.builder add r1z1-10.64.3.37:6001/c0d1 1
swift-ring-builder container.builder add r1z1-10.64.3.37:6001/c0d2 1
swift-ring-builder container.builder add r1z2-10.64.3.39:6001/c0d1 1
swift-ring-builder container.builder add r1z2-10.64.3.39:6001/c0d2 1
swift-ring-builder container.builder add r2z1-10.64.3.40:6001/c0d1 1
swift-ring-builder container.builder add r2z1-10.64.3.40:6001/c0d2 1
swift-ring-builder container.builder add r2z2-10.64.3.41:6001/c0d1 1
swift-ring-builder container.builder add r2z2-10.64.3.41:6001/c0d2 1
swift-ring-builder container.builder rebalance
swift-ring-builder account.builder create 9 4 2
swift-ring-builder account.builder add r1z1-10.64.3.37:6002/c0d1 1
swift-ring-builder account.builder add r1z1-10.64.3.37:6002/c0d2 1
swift-ring-builder account.builder add r1z2-10.64.3.39:6002/c0d1 1
swift-ring-builder account.builder add r1z2-10.64.3.39:6002/c0d2 1
swift-ring-builder account.builder add r2z1-10.64.3.40:6002/c0d1 1
swift-ring-builder account.builder add r2z1-10.64.3.40:6002/c0d2 1
swift-ring-builder account.builder add r2z2-10.64.3.41:6002/c0d1 1
swift-ring-builder account.builder add r2z2-10.64.3.41:6002/c0d2 1
swift-ring-builder account.builder rebalance
