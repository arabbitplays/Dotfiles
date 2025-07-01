#!/usr/bin/env bash

# setup folder structure

source folder_structure.sh

# setup core repositories

source repo_setup.sh

# build nix system

sudo nixos-rebuild switch --flake ~/Resources/Nixos-System#nixos

# install config files

source config_repo.sh
