#!/bin/bash

source "conf.sh"

PROGRAM_PREFIX=""

# If the installation directory is not in PATH, issue a warning
if ! echo $PATH | grep -q "$DIR"; then
    echo "Warning: '$DIR' is not in your PATH."
    echo "         To use this program, add '$DIR' to your PATH or manually copy katoolin3.py somewhere."
    echo
    PROGRAM_PREFIX="$DIR/"
fi

# Check if the shebang from katoolin3.py can execute
/usr/bin/env python3 -V >/dev/null || { echo "Please install 'python3'"; exit 1; }

# Import the GPG key for the Kali Linux repository
wget -q -O - https://archive.kali.org/archive-key.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/kali-archive-keyring.gpg || { echo "Failed to import the GPG key"; exit 1; }

# Install the required dependencies
apt-get -qq -y -m install python3-apt || { echo "Failed to install dependencies"; exit 1; }

# Install katoolin3.py
install -T -g root -o root -m 555 ./katoolin3.py "$DIR/$PROGRAM" || { echo "Failed to install katoolin3.py"; exit 1; }

echo "Successfully installed."
echo "Run it with 'sudo $PROGRAM_PREFIX$PROGRAM'."
exit 0
