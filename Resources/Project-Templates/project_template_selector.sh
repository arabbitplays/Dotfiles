#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$(dirname "$SCRIPT_DIR")/Project-Templates"
CURRENT_DIR="$(pwd)"

if [[ ! -d "$TEMPLATES_DIR" ]]; then
  echo "Templates directory not found: $TEMPLATES_DIR"
  exit 1
fi

mapfile -t templates < <(ls -1 "$TEMPLATES_DIR")

if [[ ${#templates[@]} -eq 0 ]]; then
  echo "No templates found in $TEMPLATES_DIR"
  exit 1
fi

# Guard against overwriting an existing project
if [[ -e "$CURRENT_DIR/flake.nix" ]]; then
  echo "flake.nix already exists in $CURRENT_DIR — aborting."
  exit 1
fi

echo "Select a template:"
select template in "${templates[@]}"; do
  if [[ -n "$template" ]]; then
    break
  else
    echo "Invalid selection"
  fi
done

read -rp "Project name: " project_name

if [[ -z "$project_name" ]]; then
  echo "Project name cannot be empty."
  exit 1
fi

if [[ "$project_name" =~ [^a-zA-Z0-9_-] ]]; then
  echo "Project name may only contain letters, digits, hyphens, and underscores."
  exit 1
fi

echo "Scaffolding '$project_name' from template '$template'..."

cp -r "$TEMPLATES_DIR/$template/." "$CURRENT_DIR/"

# Substitute {{PROJECT_NAME}} in all text files
while IFS= read -r file; do
  sed -i "s/{{PROJECT_NAME}}/$project_name/g" "$file"
done < <(grep -rl "{{PROJECT_NAME}}" "$CURRENT_DIR" 2>/dev/null)

echo "Done. Run 'nix develop' to enter the dev shell."
