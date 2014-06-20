# Dockerfile for nginx + monit + ssh
#
# See REAMDE.md for detail.
#
FROM ubuntu:14.04
MAINTAINER Shisei Hanai<ruimo.uno@gmail.com>

RUN apt-get update
RUN apt-get install -y nginx monit openssh-server w3m

ADD monit   /etc/monit/conf.d/

# This is a user for ssh login. Need to change the password.
RUN useradd -s /bin/bash -p password --create-home --user-group nginx
RUN gpasswd -a nginx sudo

RUN mkdir /home/nginx/.ssh
ONBUILD ADD authorized_keys /home/nginx/.ssh/authorized_keys
ONBUILD RUN chmod 755 /home/nginx
ONBUILD RUN chmod 600 /home/nginx/.ssh/authorized_keys
ONBUILD RUN chown nginx:nginx /home/nginx/.ssh/authorized_keys

EXPOSE 80
EXPOSE 22

CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]
