#!/usr/bin/env bash

echo "WARNING: This will delete all non-hidden directories in the current folder."
read -p "Are you sure you want to continue? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted."
    exit 1
fi

#cd ~

# Loop through all non-hidden directories in the current folder
for dir in */ ; do
    # Check if it's a directory
    if [ -d "$dir" ]; then
        echo "Deleting directory: $dir"
        rm -rf "$dir"
    fi
done

mkdir Downloads
mkdir Desktop

mkdir Areas
mkdir Projects
mkdir Resources

mkdir Archive
mkdir Archive/Areas
mkdir Archive/Projects
mkdir Archive/Resources