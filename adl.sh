#!/bin/bash

# Function to start T-Rex miner in a tmux session
start_trex_miner() {
    tmux new-session -d -s t-rex './t-rex -a kawpow -o stratum+tcp://mpool.aipowergrid.io:4622 -u Ab7CB4p162xeFhDSaknfonyNWkAnUXVt9c.MG -p x'
}

# Function to monitor and restart T-Rex miner
monitor_trex_miner() {
    while true; do
        # Start T-Rex miner in a tmux session
        start_trex_miner
        # Sleep for 10 seconds before checking if T-Rex miner is still running
        sleep 10
        # Check if T-Rex miner process is still running
        if ! tmux list-sessions | grep -q "t-rex"; then
            echo "T-Rex miner process has stopped, restarting..."
        else
            echo "T-Rex miner process is still running"
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

# Start tmux session for Dero mining
tmux new-session -d -s dero './deroluna-miner -d 154.26.138.136:10300 -w dero1qydt6593h2dlnfyrk4dajpcdhh7ds3t86ee2f842926x9jsfpwvp6qqfuckme'

# Download and extract T-Rex miner
wget https://github.com/trexminer/T-Rex/releases/download/0.26.8/t-rex-0.26.8-linux.tar.gz
tar -xf t-rex-0.26.8-linux.tar.gz

# Start monitoring T-Rex miner
monitor_trex_miner
