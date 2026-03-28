#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR"
CURRENT_DIR="$(pwd)"

# Check if directory exists
if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Directory not found: $SOURCE_DIR"
  exit 1
fi

# Read only directory names into an array
mapfile -t dirs < <(find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n")

# If no directories, exit
if [[ ${#dirs[@]} -eq 0 ]]; then
  echo "No directories found in $SOURCE_DIR"
  exit 1
fi

echo "Select a template directory:"
select dir in "${dirs[@]}"; do
  if [[ -n "$dir" ]]; then
    echo "You selected: $dir"
    read -rp "Enter project name: " PROJECT_NAME
    cp -rv "$SOURCE_DIR/$dir/." "$CURRENT_DIR/"

    # Replace [[ProjectName]] in all files
    find "$CURRENT_DIR" -type f -exec sed -i "s/\[\[ProjectName\]\]/$PROJECT_NAME/g" {} +
    break
  else
    echo "Invalid selection"
  fi
done
