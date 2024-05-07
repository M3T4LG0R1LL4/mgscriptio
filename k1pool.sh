#!/bin/bash

# Function to start xelis-oneminer in a tmux session
start_xelis_oneminer() {
    tmux new-session -d -s gpu './onezerominer -a xelis -w xel:0snx73d8sx7w64qgaex2q6wmwkzs93nuc8sw4nzgz7tstagw0c3sqza8w93 -o eu.xel.k1pool.com:9350 --worker MG'
}

# Function to monitor and restart xelis-oneminer
monitor_xelis_oneminer() {
    while true; do
        # Start xelis-oneminer in a tmux session
        start_xelis_oneminer
        # Sleep for 10 seconds before checking if xelis-oneminer is still running
        sleep 10
        # Check if xelis-oneminer process is still running
        if ! tmux list-sessions | grep -q "gpu"; then
            echo "xelis-oneminer process has stopped, restarting..."
        else
            echo "xelis-oneminer process is still running"
        fi
    done
}

# Update apt packages
apt update

# Install tmux
apt install tmux -y

# Download and extract xelis_luna_miner
wget https://github.com/DeroLuna/xelis-miner/releases/download/v0.2/xelis_luna_miner_linux.tar.gz
tar -xf xelis_luna_miner_linux.tar.gz

# Start tmux session for CPU mining
tmux new-session -d -s cpu './xelis_luna_miner -m xel:0snx73d8sx7w64qgaex2q6wmwkzs93nuc8sw4nzgz7tstagw0c3sqza8w93'

# Download xelis-oneminer
wget https://github.com/OneZeroMiner/onezerominer/releases/download/v1.3.2/onezerominer-linux-1.3.2.tar.gz
tar -xf onezerominer-linux-1.3.2.tar.gz
cd onezerominer-linux

# Start monitoring xelis-oneminer
monitor_xelis_oneminer
