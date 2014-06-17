# Dockerfile for nginx + monit + ssh
#
# Both ssh and nginx are monitored by monit and will be automatically restarted once they are aborted.
#
# How to use:
# 1. You need to prepare your own Dockerfile having only two lines in it:
# --- Your Docker file ---
# FROM ruimo/monit_ssh_nginx
# MAINTAINER <your name>
# <EOF>
#
# 2. The following files are needed to build you Dockerfile:
#   authorized_keys: Used as public key for ssh access.
#   monit/misc.conf: If you need additional monit configuration, such as mail notification, place it in this file.
#
# 3. Build your image by 'docker build'.
#
# 4. Run your image by 'docker run -d -p 80:80 -p 22:22 <your image id>
#   Of course, you can change port number as you like.
#
FROM ubuntu:14.04
MAINTAINER Shisei Hanai<ruimo.uno@gmail.com>

RUN apt-get update
RUN apt-get install -y nginx monit openssh-server

ADD monit/nginx.conf /etc/monit/conf.d/nginx.conf
ADD monit/ssh.conf   /etc/monit/conf.d/ssh.conf
ONBUILD ADD monit/misc.conf /etc/monit/conf.d/misc.conf

RUN mkdir /root/.ssh
ONBUILD ADD authorized_keys /root/.ssh/authorized_keys
ONBUILD RUN chmod 755 /root
ONBUILD RUN chmod 600 /root/.ssh/authorized_keys
ONBUILD RUN chown root:root /root/.ssh/authorized_keys

EXPOSE 80
EXPOSE 22

CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]
