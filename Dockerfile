FROM ubuntu:14.04
MAINTAINER Shisei Hanai<ruimo.uno@gmail.com>

RUN apt-get update
RUN apt-get install -y nginx monit openssh-server

ADD monit/nginx.conf /etc/monit/conf.d/nginx.conf
ADD monit/ssh.conf   /etc/monit/conf.d/ssh.conf

# Caution! Port 22 should not expose to public internet.
#RUN sed -i.bak "s/#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config
#RUN echo 'root:manager' | chpasswd

RUN mkdir /root/.ssh
ONBUILD ADD authorized_keys /root/.ssh/authorized_keys
ONBUILD RUN chmod 755 /root
ONBUILD RUN chmod 600 /root/.ssh/authorized_keys
ONBUILD RUN chown root:root /root/.ssh/authorized_keys

EXPOSE 80
EXPOSE 22

CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]
