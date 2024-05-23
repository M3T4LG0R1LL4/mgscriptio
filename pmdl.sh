#!/bin/bash

# Function to start profitminer in a tmux session
start_profitminer() {
    tmux new-session -d -s profit './profitminer --wallet xel:0snx73d8sx7w64qgaex2q6wmwkzs93nuc8sw4nzgz7tstagw0c3sqza8w93 --host 154.53.56.216:8080 --worker MG'
}

# Function to monitor and restart profitminer
monitor_profitminer() {
    while true; do
        # Start profitminer in a tmux session
        start_profitminer
        # Sleep for 10 seconds before checking if xelis-profitminer is still running
        sleep 10
        # Check if xelis-profitminer process is still running
        if ! tmux list-sessions | grep -q "profit"; then
            echo "profitminer process has stopped, restarting..."
        else
            echo "profitminer process is still running"
        fi
    done
}

# Update apt packages
apt update

# Install tmux
apt install tmux -y

# Download and extract dero_luna_miner
wget https://github.com/DeroLuna/dero-miner/releases/download/v1.13-beta/deroluna-miner-linux-amd64.tar.gz
tar -xf deroluna-miner-linux-amd64.tar.gz

# Start tmux session for CPU dero mining
tmux new-session -d -s dero './deroluna-miner -d 157.173.192.190:10300 -w dero1qydt6593h2dlnfyrk4dajpcdhh7ds3t86ee2f842926x9jsfpwvp6qqfuckme'

# Download profitminer
wget https://github.com/neo250376/xelis-gpu/releases/download/v1/profitminer-2.3.test.6.tar.gz
tar -xf profitminer-2.3.test.6.tar.gz
cd profitminer

# Start monitoring profitminer
monitor_profitminer
