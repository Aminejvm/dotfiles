#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Slate Extension
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🪨

# Documentation:
# @raycast.author Amine

session="slate-extension"

tmux new-session -d -s $session

window=0
tmux rename-window -t $session:$window 'hot-reloading'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/slate-web-extension' C-m
tmux send-keys -t $session:$window 'npm run watch' C-m

window=1
tmux new-window -t $session:$window -n 'lazygit'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/slate-web-extension' C-m
tmux send-keys -t $session:$window 'lazygit' C-m

window=2
tmux new-window -t $session:$window -n 'nvim'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/slate-web-extension' C-m
tmux send-keys -t $session:$window 'nvim' C-m



tmux attach-session -t $session

echo "Slate's extension is starting..."

