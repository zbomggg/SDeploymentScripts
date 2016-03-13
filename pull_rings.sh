#!/bin/bash

cd /etc/swift

rm -f *.builder *.ring.gz backups/*.builder backups/*.ring.gz

scp test@$ring_server:/etc/swift/*.ring.gz /etc/swift/

cd -
