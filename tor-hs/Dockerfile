FROM hsaito/torbox

RUN apt-get install -y openssh-server lighttpd

ADD files/torrc /etc/tor/torrc
ADD files/startup.sh /startup.sh
ADD files/sshd-key-gen.sh /sshd-key-gen.sh
ADD files/lighttpd-proxy.conf /lighttpd-proxy.conf

RUN mkdir -p /var/run/sshd
RUN echo root:changeme | chpasswd

ENTRYPOINT /startup.sh
