#!/usr/bin/env bash

# setup NixOS system repo

cd ~/Resources
git clone git@github.com:arabbitplays/Nixos-System.git
mv ~/etc/nixos/hardware-configuration.nix"
rm ~/etc/nixos/configuration.nix

# setup Obsidian repo

cd ~/Resources
git clone --recursive git@github.com:arabbitplays/Second-Brain.git


