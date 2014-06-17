dockerfile-nginx
================

# Dockerfile for nginx + monit + ssh

Both ssh and nginx are monitored by monit and will be automatically restarted once they are aborted.

# How to use:

* You need to prepare your own Dockerfile having at least two lines inside:
```
--- Your Docker file ---
FROM ruimo/dockerfile-nginx
MAINTAINER <your name>
<EOF>
```

* The following files are needed to build you Dockerfile:
```
 authorized_keys: Used as public key for ssh access.
```

* If you want to tweak nginx and monitor configuration.
 Their configuration files reside in /etc/nginx and /etc/monit/conf.d respectively. Modify them in your Dockefile.

* Build your image by ```docker build```.

* Run your image by ```docker run -d -p 80:80 -p 22:22 <your image id>```
 Of course, you can change port number as you like.
