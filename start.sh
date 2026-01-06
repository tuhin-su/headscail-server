#!/bin/bash
set -e

echo "[+] Starting OpenVPN..."
[ -f /etc/openvpn/client.ovpn ] && openvpn --config /etc/openvpn/client.ovpn --daemon

sleep 5

echo "[+] Starting Headscale..."
headscale serve
