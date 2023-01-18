#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Slate
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🪨

# Documentation:
# @raycast.description Start slate dev server
# @raycast.author Amine

session="slate-shovel"

tmux new-session -d -s $session

window=0
tmux rename-window -t $session:$window 'hot-reloading'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/shovel' C-m
tmux send-keys -t $session:$window 'yarn dev' C-m

window=1
tmux new-window -t $session:$window -n 'lazygit'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/shovel' C-m
tmux send-keys -t $session:$window 'lazygit' 

window=2
tmux new-window -t $session:$window -n 'nvim'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/shovel' C-m
tmux send-keys -t $session:$window 'nvim' C-m

session="slate-fiji"

tmux new-session -d -s $session

window=0
tmux rename-window -t $session:$window 'hot-reloading'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/fiji' C-m
tmux send-keys -t $session:$window 'yarn dev' C-m

window=1
tmux new-window -t $session:$window -n 'lazygit'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/fiji' C-m
tmux send-keys -t $session:$window 'lazygit' 

window=2
tmux new-window -t $session:$window -n 'nvim'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/fiji' C-m
tmux send-keys -t $session:$window 'nvim' C-m


session="slate"

tmux new-session -d -s $session

window=0
tmux rename-window -t $session:$window 'hot-reloading'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/slate' C-m
tmux send-keys -t $session:$window 'yarn dev' C-m

window=1
tmux new-window -t $session:$window -n 'lazygit'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/slate' C-m
tmux send-keys -t $session:$window 'lazygit' C-m

window=2
tmux new-window -t $session:$window -n 'nvim'
tmux send-keys -t $session:$window 'cd ~/Documents/filecoin/slate' C-m
tmux send-keys -t $session:$window 'nvim' C-m

tmux attach-session -t $session

echo "Slate is starting..."

