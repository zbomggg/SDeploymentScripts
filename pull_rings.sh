#!/bin/bash
source localrc.sh

cd /etc/swift

rm -f *.builder *.ring.gz backups/*.builder backups/*.ring.gz

scp $username@$ring_server:/etc/swift/*.ring.gz /etc/swift/

cd -
