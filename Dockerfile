# Use Alpine Linux as a base image
FROM alpine:latest

# Install OpenSSH, sudo, and Python
RUN apk add --no-cache openssh sudo python3

# Expose the SSH port
EXPOSE 22

# Command to start the SSH daemon
CMD ["/usr/sbin/sshd", "-D"]
