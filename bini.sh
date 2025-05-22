#!/bin/bash

# Script to download an executable file from a URL to /usr/local/bin/ with optional custom filename
# Usage: bini <url> [<output_filename>]

# Verify if the URL has been passed as an argument
if [ -z "$1" ]; then
    echo "bini: bin installer: install from a remote binary file"
    echo
    echo "Usage: bini <url> [<output_filename>]"
    echo
    echo "Arguments:"
    echo "   <url> the url to a binary file"
    echo "   [<output_filename>] optional output filename of the binary"
    echo
  exit 1
fi

URL="$1"
OUTPUT_FILENAME="$2"

# Parse the base file name from the URL if no output filename is provided
if [ -z "$OUTPUT_FILENAME" ]; then
  OUTPUT_FILENAME=$(basename "$URL")
fi

# Define the target directory
TARGET_DIR="/usr/local/bin"

# Full path for the output file in /usr/local/bin
OUTPUT_PATH="$TARGET_DIR/$OUTPUT_FILENAME"

# Download the file using wget with sudo
echo "Downloading $URL to $OUTPUT_PATH..."
if sudo wget -O "$OUTPUT_PATH" "$URL"; then
  echo "Download completed: $OUTPUT_PATH"
else
  echo "Error: Download failed!"
  exit 1
fi

# Set execute permissions on the downloaded file
if sudo chmod +x "$OUTPUT_PATH"; then
  echo "Set execute permission on $OUTPUT_PATH"
else
  echo "Error: Failed to set execute permission!"
  exit 1
fi

echo "Operation completed successfully."
exit 0

