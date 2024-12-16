FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y openssh-server && \
    rm -rf /var/lib/apt/lists/*

# Configuration SSH
RUN mkdir -p /run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Ajout des clés autorisées
COPY authorized_keys /root/.ssh/authorized_keys

RUN chmod 600 /root/.ssh/authorized_keys && \
    chmod 700 /root/.ssh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]