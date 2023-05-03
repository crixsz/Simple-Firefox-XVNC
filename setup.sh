#!/bin/bash

REQUIRED_PACKAGES=(firefox-esr xvfb x11vnc expect tightvncserver)

# Check if the required packages are installed:
for package in "${REQUIRED_PACKAGES[@]}"; do
   if ! [ -x "$(command -v ${package})" ]; then
      echo "${package} is not installed, installing..."
      apt update
      apt install -y ${package}
   else
      clear
      echo "${package} is already installed"
   fi
done
# Define the VNC server auth directory:
VNC_AUTH_DIR="/root/.vnc"

# Define the VNC server auth file:
VNC_AUTH_FILE="passwd"

VNC_PASSWORD="zoxxenon"
# Generate the VNC password with expect:
expect << EOF
        spawn vncpasswd
        expect "Password:"
        send "${VNC_PASSWORD}\r"
        expect "Verify:"
        send "${VNC_PASSWORD}\r"
        expect "Would you like to enter a view-only password (y/n)?"
        send "n\r"
        expect eof
EOF
    chmod 600 "${VNC_AUTH_DIR}/${VNC_AUTH_FILE}"
sleep 3
clear 
echo "Installation completed"
