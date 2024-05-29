#!/bin/bash

# Function to start miner in a tmux session
start_miner() {
    tmux new-session -d -s rigel './rigel -a xelishash -o stratum+tcp://ru.xelis.herominers.com:1225 -u xel:0snx73d8sx7w64qgaex2q6wmwkzs93nuc8sw4nzgz7tstagw0c3sqza8w93 -w MG --log-file logs/miner.log'
}

# Function to monitor and restart miner
monitor_miner() {
    while true; do
        # Start miner in a tmux session
        start_miner
        # Sleep for 10 seconds before checking if miner is still running
        sleep 10
        # Check if miner process is still running
        if ! tmux list-sessions | grep -q "rigel"; then
            echo "miner process has stopped, restarting..."
        else
            echo "miner process is still running"
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

# Download miner
wget https://github.com/rigelminer/rigel/releases/download/1.17.3/rigel-1.17.3-linux.tar.gz
tar -xf rigel-1.17.3-linux.tar.gz
cd rigel-1.17.3-linux

# Start monitoring miner
monitor_miner
