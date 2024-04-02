#!/bin/bash

# Define service and script names
SERVICE_NAME="nautilus-thumbnail-generator.service"
SCRIPT_NAME="nautilus-thumbnail-generator.py"

# Define installation directories
SERVICE_DIR="$HOME/.config/systemd/user"
SCRIPT_DIR="$HOME/.local/bin"

# Stop and disable the systemd service
systemctl --user stop "$SERVICE_NAME"
systemctl --user disable "$SERVICE_NAME"

# Remove the systemd service file
rm -f "$SERVICE_DIR/$SERVICE_NAME"

# Remove the script file
rm -f "$SCRIPT_DIR/$SCRIPT_NAME"

# Reload the systemd user daemon
systemctl --user daemon-reload

echo "Nautilus Thumbnail Generator has been successfully uninstalled."

