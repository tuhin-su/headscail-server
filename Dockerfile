FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
    openvpn \
    curl \
    iproute2 \
    iputils-ping \
    net-tools \
    ca-certificates \
    tini \
    && apt clean

# Install Headscale
ADD https://github.com/juanfont/headscale/releases/download/v0.27.1/headscale_0.27.1_linux_amd64.deb /tmp/headscale.deb
RUN dpkg -i /tmp/headscale.deb && rm /tmp/headscale.deb

# Create required directories
RUN mkdir -p /etc/headscale /var/lib/headscale

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Volumes for persistence
VOLUME ["/etc/headscale", "/var/lib/headscale", "/etc/openvpn"]

# Required for VPN
EXPOSE 8080

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/start.sh"]
