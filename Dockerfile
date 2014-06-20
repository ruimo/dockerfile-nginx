# Dockerfile for nginx + monit + ssh
#
# See REAMDE.md for detail.
#
FROM ubuntu:14.04
MAINTAINER Shisei Hanai<ruimo.uno@gmail.com>

RUN apt-get update
RUN apt-get install -y nginx monit openssh-server w3m

ADD monit   /etc/monit/conf.d/

# This is a user for ssh login. Initial password = 'password'.
RUN useradd -p `perl -e "print(crypt('password', 'AB'));"` -s /bin/bash --create-home --user-group nginx

# Force to change password.
RUN passwd -e nginx
RUN gpasswd -a nginx sudo

# Use non standard port for ssh(22) to prevent atack.
RUN sed -i.bak "s/Port 22/Port 2201/" /etc/ssh/sshd_config

RUN mkdir /home/nginx/.ssh
ONBUILD ADD authorized_keys /home/nginx/.ssh/authorized_keys
ONBUILD RUN chmod 755 /home/nginx
ONBUILD RUN chmod 600 /home/nginx/.ssh/authorized_keys
ONBUILD RUN chown nginx:nginx /home/nginx/.ssh/authorized_keys

EXPOSE 80
EXPOSE 2201

CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]
