# Use Alpine Linux as a base image
FROM alpine:latest

# Install OpenSSH, sudo, and Python
RUN apk add --no-cache openssh sudo python3

# Create user dmora with a home directory
RUN adduser -D dmora

# Set the password for user dmora
RUN echo "dmora:password" | chpasswd

# Generate host keys
RUN ssh-keygen -A

# Configure SSH to allow password and public key authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

# Create .ssh directory for user dmora
RUN mkdir -p /home/dmora/.ssh && chmod 700 /home/dmora/.ssh && chown dmora:dmora /home/dmora/.ssh

# Allow dmora to run commands with sudo without password
RUN echo "dmora ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dmora

# Expose the SSH port
EXPOSE 22

# Command to start the SSH daemon
CMD ["/usr/sbin/sshd", "-D"]
