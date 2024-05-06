# Use a minimalistic base image
FROM scratch

# Add the necessary files
ADD rootfs.tar.gz /

# Install OpenSSH and Python
RUN apk add --no-cache openssh python3