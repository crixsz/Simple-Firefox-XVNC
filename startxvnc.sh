# Define the VNC server display number:
VNC_DISPLAY=1

# Define the VNC server port:
VNC_PORT=5901

# Define the VNC server auth directory:
VNC_AUTH_DIR="/root/.vnc"

# Define the VNC server auth file:
VNC_AUTH_FILE="passwd"

# Start the VNC server in the background:
function start_vnc_server {
   # Start Xvfb:
   Xvfb :${VNC_DISPLAY} -screen 0 1366x768x24 &> /dev/null &
   # Start Firefox:
   DISPLAY=:${VNC_DISPLAY} firefox-esr &> /dev/null &

   # Start x11vnc with password authentication:
   x11vnc -display :${VNC_DISPLAY} -rfbport ${VNC_PORT} -rfbauth "${VNC_AUTH_DIR}/${VNC_AUTH_FILE}" -shared &> /dev/null &
}

# Stop the VNC server:
function stop_vnc_server {
   pkill firefox-esr 2> /dev/null
   pkill x11vnc 2> /dev/null
   pkill Xvfb 2> /dev/null
   exit 0
}

# Check if VNC server is already running:
if pgrep -x "firefox-esr" > /dev/null || \
   pgrep -x "xvfb" > /dev/null || \
   pgrep -x "x11vnc" > /dev/null; then   
   echo "VNC server is already running!"
   echo "Stopping VNC..."
   stop_vnc_server
else
   echo "Starting VNC server..."
fi

# Start the VNC server:
start_vnc_server 

echo "VNC server is now running on port ${VNC_PORT}!"
