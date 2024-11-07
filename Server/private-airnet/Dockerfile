FROM debian:latest

RUN apt-get update && \
    apt-get install -y && \
    apt-get -y install curl autossh systemctl cron netcat-openbsd nano python3 && \
    apt-get -y install iputils-ping net-tools openssh-server

COPY ./authorized_keys /root/.ssh/authorized_keys

WORKDIR /usr/local/bin
COPY ./tcpListener.sh /usr/local/bin
RUN chmod +x /usr/local/bin/tcpListener.sh

EXPOSE 7880

CMD ["/usr/local/bin/tcpListener.sh"]