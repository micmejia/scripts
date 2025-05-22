#!/bin/bash

# Function to show usage
usage() {
    echo "debi: .deb installer: install from a remote .deb file"
    echo
    echo "Usage: debi <url>"
    echo
    echo "Arguments:"
    echo "   <url> the url to a .deb file"
    echo
    exit 1
}

# Check if the user provided an argument
if [ "$#" -ne 1 ]; then
    usage
fi

# Set variables
URL="$1"
TEMP_DIR=$(mktemp -d)
FILE_NAME=$(basename "$URL")

# Download the file using wget
echo "Downloading $URL..."
if wget -q -P "$TEMP_DIR" "$URL"; then
    echo "Download completed: $TEMP_DIR/$FILE_NAME"
else
    echo "Failed to download $URL"
    exit 1
fi

# Install the downloaded file using apt
echo "Installing $FILE_NAME..."
if sudo apt install -y "$TEMP_DIR/$FILE_NAME"; then
    echo "Installation successful."
else
    echo "Installation failed."
    exit 1
fi

# Clean up temporary directory
rm -rf "$TEMP_DIR"
echo "Temporary files cleaned up."

exit 0

