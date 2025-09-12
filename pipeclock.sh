#!/bin/bash

# Function that checks for pipewire installation
function pipewire_check() {
    # Checks for pipewire installation
    if pipewire --version > /dev/null 2>&1; then
        version=$(pipewire --version | awk 'NR==2 {print $4}')
        echo "Pipewire is installed, version $version"
    else
        echo "Pipewire is not installed."
    fi
}
pipewire_check