#!/bin/bash
# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.
#exec /sbin/setuser memcache /usr/bin/memcached >>/var/log/memcached.log 2>&1
# Determine first run
#tr -dc 'A-Za-z0-9_!@#$%^&*()' < /dev/urandom | head -c 10 | xargs
if [ ! -f "/usr/local/Xeoma/.firstrun" ]
then
	ls -al /usr/local/Xeoma/.firstrun
	/root/xeoma.app -setpassword `tr -dc 'A-Za-z0-9_!@#$%^&*()' < /dev/urandom | head -c 10 | xargs`
	touch /usr/local/Xeoma/.firstrun
fi

/root/bin/Xeoma/xeoma -showpassword
/root/bin/Xeoma/xeoma -core -service -log -startdelay 5
