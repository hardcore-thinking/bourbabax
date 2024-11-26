FROM debian:latest

RUN apt-get update && \
    apt-get install -y && \
    apt-get -y install curl autossh systemctl cron netcat-openbsd nano python3 && \
    apt-get -y install iputils-ping net-tools openssh-server && \
    apt-get -y install python3-pip && \
    apt-get -y install python3-venv

RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"
RUN pip install --no-cache-dir mysql-connector-python

WORKDIR /usr/local/bin
COPY ./tcp_service.sh /usr/local/bin
COPY ./get_public_keys.py /usr/local/bin
COPY ./check_who_is_dead.py /usr/local/bin

EXPOSE 7880

# Start the TCP service [Server API <> Airnet Private Server]
CMD ["bash","/usr/local/bin/tcp_service.sh"]