dockerfile-nginx
================

# Dockerfile for nginx + monit + ssh

Both ssh and nginx are monitored by monit and will be automatically restarted once they are aborted.

# How to use:

* You need to prepare your own Dockerfile having only two lines in it:
```
    --- Your Docker file ---
    FROM ruimo/monit_ssh_nginx
    MAINTAINER <your name>
    <EOF>
```

* The following files are needed to build you Dockerfile:
```
 authorized_keys: Used as public key for ssh access.
 monit/misc.conf: If you need additional monit configuration, such as mail notification, place it in this file.
```

* Build your image by ```docker build```.

* Run your image by ```docker run -d -p 80:80 -p 22:22 <your image id>```
 Of course, you can change port number as you like.
