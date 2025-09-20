#!/bin/bash

pcVersion="0.2-alpha" 
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

# This checks and makes the necessary folders for Pipeclock to run
function folder_make() {
    echo "Making Pipewire config folder"
    if [ ! -d "$HOME/.config" ]; then
        mkdir "$HOME/.config"
    fi

    if [ ! -d "$HOME/.config/pipewire" ]; then
        mkdir "$HOME/.config/pipewire"
    fi

    if [ ! -d "$HOME/.config/pipewire/pipewire.conf.d" ]; then
        mkdir "$HOME/.config/pipewire/pipewire.conf.d"
    fi
}

function clock_preferences() {
    echo -e "Welcome to Pipeclock v$pcVersion!"
    while true; do
        echo -e "\nPlease select minimum clock speed"
        echo "1. 44100
2. 48000
3. 88200
4. 96000
5. 192000
** (1-5, 0 to abort) **
"
        # read is like input() on python, accepts input
        read minClock
        if [ "$minClock" -eq "0" ]; then
            echo -e "\nExiting Pipeclock v$pcVersion"
            exit 1
        elif [ "$minClock" -eq "1" ]; then
            minClock=44100
            break
        elif [ "$minClock" -eq "2" ]; then
            minClock=48000
            break
        elif [ "$minClock" -eq "3" ]; then
            minClock=88200
            break
        elif [ "$minClock" -eq "4" ]; then
            minClock=96000
            break
        elif [ "$minClock" -eq "5" ]; then
            minClock=192000
            break
        else
            echo -e "\nError: Please enter a number that is 0-5"
        fi
    done
    echo -e "\nYou have chosen $minClock as your minimum clock rate"
    while true; do
        echo -e "\nPlease select maximum clock speed"
        echo "1. 44100
2. 48000
3. 88200
4. 96000
5. 192000
** (1-5, 0 to abort) **
"
        read maxClock
        if [ "$maxClock" -eq "0" ]; then
            echo -e "\nExiting Pipeclock v$pcVersion"
            exit 1
        elif [ "$maxClock" -eq "1" ]; then
            maxClock=44100
            break
        elif [ "$maxClock" -eq "2" ]; then
            maxClock=48000
            break
        elif [ "$maxClock" -eq "3" ]; then
            maxClock=88200
            break
        elif [ "$maxClock" -eq "4" ]; then
            maxClock=96000
            break
        elif [ "$maxClock" -eq "5" ]; then
            maxClock=192000
            break
        else
            echo -e "\nError: Please enter a number that is 0-5"
        fi
    done
    echo -e "\nYou have chosen $maxClock as your maximum clock rate"
}

function find_rates() {
    if (( $minClock == $maxClock )); then
        clockRate=$maxClock
    fi
    if (( $minClock < $maxClock )); then
        clockRate=$minClock
        if (( $maxClock >= 48000 && $minClock < 48000 )); then
            clockRate="$clockRate ,48000"
        fi
        if (( $maxClock >= 88200 && $minClock < 82000 )); then
            clockRate="$clockRate ,88200"
        fi
        if (( $maxClock >= 96000 && $minClock < 96000 )); then
            clockRate="$clockRate ,96000"
        fi
        if (( $maxClock == 192000 )); then
            clockRate="$clockRate ,192000"
        fi
    fi
    # Error handling
    if (( $minClock > $maxClock )); then
        echo "Incorrect values selected, aborting..."
        exit 1
    fi
}

function make_conf() {
    echo "Making configuration file"
    touch "$HOME/.config/pipewire/pipewire.conf.d/clock.conf"
    cat <<EOF > "$HOME/.config/pipewire/pipewire.conf.d/clock.conf"
context.properties {
    default.clock.allowed-rates = [ $clockRate ]
}
EOF
}

pipewire_check
clock_preferences
find_rates
folder_make
make_conf
systemctl --user restart pipewire pipewire-pulse
echo "Done! Thanks for using Pipeclock!"
#if [ ! -e "$HOME/.config/pipewire/pipewire.conf.d/clock.conf" ]; then
#    make_conf
#elif [ -e "$HOME/.config/pipewire/pipewire.conf.d/clock.conf" ]; then
#    edit_conf
#fi