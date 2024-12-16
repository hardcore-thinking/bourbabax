# Use the official Debian image as a base
FROM debian:12.8

# Install SSH server, create the directory for SSH keys, and set root password
RUN apt-get update && \
    apt-get install -y iputils-ping nano net-tools netcat-openbsd openssh-server python3 && \
    mkdir /var/run/sshd && \
    echo "root:bourbabax255" | chpasswd && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY addPublicKeys.sh /usr/local/bin

COPY ssh-keys/reverse_ssh_key /root/.ssh/reverse_ssh_key

RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    chmod +x /usr/local/bin/addPublicKeys.sh && \
    chmod 600 /root/.ssh/reverse_ssh_key

# Expose necessary ports
EXPOSE 80 443 22 2222

# Command to run on container start: starts SSH, runs Nginx, and initiates reverse SSH tunnel
CMD ["/bin/sh", "-c", "service ssh start && ssh -i /root/.ssh/reverse_ssh_key -o 'StrictHostKeyChecking=no' -N -R 2222:localhost:22 root@localhost & nginx -g 'daemon off;'"]