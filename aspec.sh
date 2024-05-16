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

# Download and extract tnn miner
wget https://github.com/neo250376/xelis-gpu/releases/download/v1/tnn-miner-v0.3.4.br1.1.tar.gz
tar -xf tnn-miner-v0.3.4.br1.1.tar.gz
cd tnn-miner

# Start tmux session for spectre mining
tmux new-session -d -s tnn './tnn-miner --spectre --daemon-address 195.26.252.56 --port 5555 --wallet spectre:qqte4mp8098wc83qauj76kzra42m25n652gqp4332653jk32m8a6w4ktejqa2 --no-lock --threads $(nproc) --dev-fee 1'

# Download and extract T-Rex miner
wget https://github.com/trexminer/T-Rex/releases/download/0.26.8/t-rex-0.26.8-linux.tar.gz
tar -xf t-rex-0.26.8-linux.tar.gz

# Start monitoring T-Rex miner
monitor_trex_miner
