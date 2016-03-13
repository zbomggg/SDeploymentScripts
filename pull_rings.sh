#!/bin/bash

cd /etc/swift

rm -f *.builder *.ring.gz backups/*.builder backups/*.ring.gz

scp test@10.64.3.37:/etc/swift/*.ring.gz /etc/swift/

cd -
