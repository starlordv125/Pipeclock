#!/bin/bash

# Function that checks for pipewire installation
function pipewire_check() {
    # Checks for pipewire installation
    if pipewire --version > /dev/null 2>&1; then
        version=$(pipewire --version | awk 'NR==2 {print $4}')
        echo "Pipewire is installed, version $version"
    else
        # Hides error message
        2> /dev/null
        echo "Pipewire is not installed."
        exit 1
    fi
}

function file_check() {
    if [ ! -d "$HOME/.config" ]; then
        mkdir "$HOME/.config"
    fi

    if [ ! -d "$HOME/.config/pipewire" ]; then
        mkdir "$HOME/.config/pipewire"
    fi

    if [ -f "$HOME/.config/pipewire/pipewire.conf" ]; then
        echo "WORKS"
    else
        touch "$HOME/.config/pipewire/pipewire.conf"
    fi
}
pipewire_check
file_check