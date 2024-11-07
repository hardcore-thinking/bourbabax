# Use the official Nginx image as a base
FROM nginx:latest

# Install SSH server and create the directory for SSH keys
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get install -y python3 && \
    mkdir /var/run/sshd

RUN echo "root:bourbabax255" | chpasswd

COPY tcpClient.py /home/tcpClient.py

# Copy SSH key for reverse SSH tunnel and set permissions
# COPY ./reverse_ssh_key /root/.ssh/reverse_ssh_key
# RUN chmod 600 /root/.ssh/reverse_ssh_key

# Expose necessary ports
EXPOSE 80 443 22 2222

# Command to run on container start: starts SSH, runs Nginx, and initiates reverse SSH tunnel
CMD service ssh start && \
    ssh -i /root/.ssh/reverse_ssh_key -o "StrictHostKeyChecking=no" -N -R 2222:localhost:22 root@localhost & \
    nginx -g 'daemon off;'
