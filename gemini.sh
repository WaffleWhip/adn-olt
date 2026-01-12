#!/bin/bash

# --- Configuration ---
CTID="100"
HOSTNAME="Gemini-CLI"
BRIDGE="vmbr0"
PASSWORD="telkom123" # Password for the container root
STORAGE_ISO="local"
RAM="4096" # 4GB RAM

echo "--- 1. Updating Proxmox Template Database ---"
pveam update

echo "--- 2. Detecting Latest Debian Template ---"
LATEST_DEBIAN=$(pveam available --section system | grep "debian-" | awk '{print $2}' | sort -V | tail -n 1)

if [ -z "$LATEST_DEBIAN" ]; then
    echo "Error: Could not find a Debian template."
    exit 1
fi
echo "Selected Template: $LATEST_DEBIAN"

# Download template if not exists
if [ ! -f "/var/lib/vz/template/cache/$LATEST_DEBIAN" ]; then
    echo "Downloading template..."
    pveam download $STORAGE_ISO "$LATEST_DEBIAN" || { echo "Download failed"; exit 1; }
fi

echo "--- 3. Detecting Valid Storage for Disk ---"
STORAGE_DISK=$(pvesm status -content rootdir | awk 'NR>1 {print $1}' | head -n 1)

if [ -z "$STORAGE_DISK" ]; then
    echo "Error: No storage found for LXC disks."
    exit 1
fi
echo "Using Storage: $STORAGE_DISK"

echo "--- 4. Creating LXC Container ---"
if pct status $CTID >/dev/null 2>&1; then
    echo "Error: CTID $CTID already exists. Remove it first using 'pct destroy $CTID'."
    exit 1
fi

# Create container with 4GB RAM, Unlimited CPU (default), and Autostart
pct create $CTID "$STORAGE_ISO:vztmpl/$LATEST_DEBIAN" \
    --hostname "$HOSTNAME" \
    --net0 name=eth0,bridge=$BRIDGE,ip=dhcp \
    --storage "$STORAGE_DISK" \
    --password "$PASSWORD" \
    --memory "$RAM" \
    --swap 512 \
    --onboot 1 \
    --unprivileged 1 \
    --features nesting=1 \
    --start 1 || { echo "Failed to create container"; exit 1; }

echo "--- 5. Waiting for Network Connectivity ---"
sleep 5
MAX_RETRIES=15
COUNT=0
until pct exec $CTID -- ping -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; do
    echo "Waiting for DHCP... ($COUNT)"
    sleep 2
    ((COUNT++))
    if [ $COUNT -ge $MAX_RETRIES ]; then
        echo "Error: Network timeout."
        exit 1
    fi
done

echo "--- 6. Installing SSH, Node.js, and Gemini CLI ---"
pct exec $CTID -- bash -e -c "
    apt update
    apt install -y curl gnupg openssh-server
    
    # Configure SSH
    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    systemctl enable ssh
    systemctl start ssh

    # Install Node.js (Latest)
    curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
    apt install -y nodejs
    
    # Install Gemini CLI
    npm install -g @google/gemini-cli
"

if [ $? -eq 0 ]; then
    # Get the IP Address to show the user
    IP_ADDR=$(pct exec $CTID -- ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

    echo "-------------------------------------------------------"
    echo " SUCCESS: Gemini-CLI is ready!"
    echo "-------------------------------------------------------"
    echo " Container ID  : $CTID"
    echo " RAM           : 4GB"
    echo " CPU           : Unlimited (Host Default)"
    echo " Persistence   : Enabled (Start on boot)"
    echo " Container IP  : $IP_ADDR"
    echo " SSH Command   : ssh root@$IP_ADDR"
    echo " Gemini Command: gemini"
    echo "-------------------------------------------------------"
else
    echo "Error: Installation failed."
    exit 1
fi