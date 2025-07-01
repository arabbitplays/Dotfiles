#!/usr/bin/env bash

git clone --bare git@github.com:arabbitplays/Dotfiles.git $HOME/.cfg
function config {
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
    echo "Checked out config."
    else
        echo "Backing up pre-existing dot files.";
        config checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | while read -r file; do
            if [ -f "$file" ] || [ -d "$file" ]; then
                # Create parent directory for the backup file, if it doesn't exist
                mkdir -p "$(dirname ".config-backup/$file")"
                mv "$file" ".config-backup/$file"
            fi
        done
fi;
config checkout
config config status.showUntrackedFiles no

# Copy hardware configuration to the right place
cp ~/etc/nixos/hardware-configuration.nix" .nixos/hardware-configuration