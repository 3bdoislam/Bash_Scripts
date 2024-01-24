#!/bin/bash

# Function to print script usage
usage() {
    echo "Usage: $0 -c -o <OPENVPN_CONFIG_FILE> -p -d"
    echo "Options:"
    echo "  -c    Connect using Warp"
    echo "  -o    Connect using OpenVPN in the background"
    echo "  -p    Second check: Ping 10.10.10.10 -c 3"
    echo "  -d    Disconnect from Warp"
    echo "  -D    Disconnecting from OpenVPN..."
    exit 
}

# Function to check if a command is successful
check_command() {
    if [ $? -eq 0 ]; then
        echo "[SUCCESS] $1"
    else
        echo "[ERROR] $1"
        exit 
    fi
}

# Process of command line arguments 
while [ "$#" -gt 0 ]; do
    case "$1" in
        -c)
            echo "Connecting using Warp..."
            sudo warp-cli connect
            check_command "Connected using Warp"
            ;;
        -o)
            echo "Connecting using OpenVPN in the background..."
            shift
            openvpn_config="$1"
            sudo openvpn --config "$openvpn_config" --daemon
            check_command "Connected using OpenVPN"
            ;;
        -p)
            echo "Second check: Pinging 10.10.10.10 -c 3..."
            ping -c 3 10.10.10.10
            check_command "Ping successful"
            ;;
        -d)
            echo "Disconnecting from Warp..."
            sudo warp-cli disconnect
            check_command "Disconnected from Warp"
            ;;
        -D)
            echo "Disconnecting from OpenVPN..."
            sudo pkill openvpn
            check_command "Disconnected from OpenVPN"
            ;;
        *)
            echo "Invalid option: $1"
            usage
            ;;
    esac
    shift
done

# If no options are provided, print usage
if [ "$#" -eq 0 ]; then
    usage
fi