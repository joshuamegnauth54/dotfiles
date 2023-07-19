#/bin/sh

mount -o umask=0022,gid=1000,uid=1000,noatime,nosetuid,ro,noexec $1 $2
