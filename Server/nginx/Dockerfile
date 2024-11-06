# Use the Nginx image as a base
FROM nginx:latest

# Install OpenSSH server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# Set up password for the root user (adjust as needed for your environment)
RUN echo 'root:yourpassword' | chpasswd

# Expose both HTTP and SSH ports
EXPOSE 80 443 22

# Start SSH and Nginx
CMD service ssh start && nginx -g 'daemon off;'
