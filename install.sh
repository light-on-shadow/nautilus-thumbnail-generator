#!/bin/bash

# Define paths
INSTALL_DIR="$HOME/.local/bin"
SERVICE_DIR="$HOME/.config/systemd/user"
SCRIPT_NAME="nautilus-thumbnail-generator.py"
SERVICE_NAME="nautilus-thumbnail-generator.service"

# Ensure the script and service template exist
if [ ! -f "$SCRIPT_NAME" ] || [ ! -f "$SERVICE_NAME.template" ]; then
    echo "Required files are missing."
    exit 1
fi

# Check and install Python package dependencies
if ! python3 -c "import watchdog" &> /dev/null; then
    if [ -f "requirements.txt" ]; then
        echo "Installing Python dependencies..."
        python3 -m pip install --user -r requirements.txt
    else
        echo "requirements.txt is missing. Cannot install Python dependencies."
        exit 1
    fi
fi

# Prepare installation directories
mkdir -p "$INSTALL_DIR"
mkdir -p "$SERVICE_DIR"

# Install the Python script
SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"
cp "$SCRIPT_NAME" "$SCRIPT_PATH"
chmod +x "$SCRIPT_PATH"

# Configure and install the systemd service
SERVICE_FILE_PATH="$SERVICE_DIR/$SERVICE_NAME"
sed "s|ExecStart=.*|ExecStart=$SCRIPT_PATH|" "$SERVICE_NAME.template" > "$SERVICE_FILE_PATH"

# Enable and start the systemd service
systemctl --user daemon-reload
systemctl --user enable "$SERVICE_NAME"
systemctl --user start "$SERVICE_NAME"

echo "Nautilus Thumbnail Generator installed and started successfully."

