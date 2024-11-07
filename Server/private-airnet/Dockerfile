FROM debian:latest

RUN apt-get update && \
    apt-get install -y && \
    apt-get -y install curl autossh systemctl cron netcat-openbsd nano python3 && \
    apt-get -y install iputils-ping net-tools

# COPY ./authorized_keys /root/.ssh/authorized_keys

COPY tcpServerListenor.py /home/tcpServerListenor.py

EXPOSE 7880

CMD ["python3", "/home/tcpServerListenor.py"]
CMD ["tail", "-f", "/dev/null"]
