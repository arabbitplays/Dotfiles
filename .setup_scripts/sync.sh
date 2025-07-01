#!/usr/bin/env bash
now="$(date)"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519   # or your specific key path

#onedrive --sync

echo "Sync Obsidian Repositories"
echo "--------------------------"

cd ~/Resources/Second-Brain
git pull
git add .
git commit -a -m "sync $now"
git push

cd Zettelkasten
git pull
git add .
git commit -a -m "sync $now"
git push

echo "Sync Dotfiles"
echo "--------------------------"

config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
$config pull
$config add .
$config commit -a -m "sync $now"
$config push

echo "Sync Nixos Files"
echo "--------------------------"

cd ~/Resources/Nixos-System
git pull
git add .
git commit -a -m "sync $now"
git push