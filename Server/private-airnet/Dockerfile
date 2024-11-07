FROM debian:latest

RUN apt-get update && \
    apt-get install -y && \
    apt-get -y install curl autossh systemctl cron

COPY authorized_keys /root/.ssh/authorized_keys

EXPOSE 7880 

CMD ["tail", "-f", "/dev/null"]
