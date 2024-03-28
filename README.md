# Nautilus Thumbnail Generator

The Nautilus Thumbnail Generator is a Python-based service that automatically creates thumbnails for images in specified directories. It integrates with the Nautilus file manager, ensuring that thumbnails are generated and updated as files are added or modified.
This approach serves as a temporary solution for situations where thumbnails fail to load while accessing the recent menu or using the file picker.

## Features

- Generates thumbnails for images efficiently in the background.
- Watches for new or updated files in real-time to keep thumbnails current.

## Prerequisites

- Tested on Fedora 39
- systemd
- Python 3
- `watchdog` Python package
- `gdk-pixbuf-thumbnailer`

## Installation

To install the Nautilus Thumbnail Generator, follow these steps:

1. Clone the repository:

```bash
git clone https://github.com/yourusername/nautilus-thumbnail-generator.git
```

2. Navigate to the project directory:

```bash
cd nautilus-thumbnail-generator
```

3. Make the install script executable and run it:

```bash
chmod +x install.sh
./install.sh
```

This script will install the necessary files and set up a user service to run the thumbnail generator automatically.

## Usage

Once installed, the Nautilus Thumbnail Generator will start automatically and monitor the specified directory (default is ~/Pictures). Thumbnails will be generated in the appropriate cache directory and used by Nautilus or other file managers that follow the FreeDesktop.org thumbnail specification.

## Uninstallation

To uninstall the Nautilus Thumbnail Generator, follow these steps:

1. Navigate to the project directory (if not already there):

```bash
cd nautilus-thumbnail-generator
```

2. Make the uninstall script executable and run it:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

This script will stop the service, remove installed files, and clean up the system service entries.
# nautilus-thumbnail-generator
