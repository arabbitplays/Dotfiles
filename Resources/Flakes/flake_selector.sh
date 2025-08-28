#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/templates"
CURRENT_DIR="$(pwd)" # Get the current directory of the terminal


# Check if directory exists
if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Directory not found: $SOURCE_DIR"
  exit 1
fi

# Read all filenames into an array
mapfile -t files < <(ls -1 "$SOURCE_DIR")

# If no files, exit
if [[ ${#files[@]} -eq 0 ]]; then
  echo "No files found in $SOURCE_DIR"
  exit 1
fi

echo "Select a template:"
select file in "${files[@]}"; do
  if [[ -n "$file" ]]; then
    echo "You selected: $file"
    cp "$SOURCE_DIR/$file" "$CURRENT_DIR/flake.nix"
    break
  else
    echo "Invalid selection"
  fi
done

