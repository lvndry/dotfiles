#!/usr/bin/env bash
set -euo pipefail

# Usage: ./ssh/github.sh [email] [key_name]
# Example: ./ssh/github.sh you@example.com personal-mac

EMAIL="${1:-$(git config user.email || echo "you@example.com")}"
KEY_NAME="${2:-github-$(hostname)}"
KEY_DIR="$HOME/.ssh"
KEY_PATH="$KEY_DIR/${KEY_NAME}"

mkdir -p "$KEY_DIR"
chmod 700 "$KEY_DIR"

if [ -f "$KEY_PATH" ] || [ -f "${KEY_PATH}.pub" ]; then
  echo "Key already exists at $KEY_PATH(.pub). Aborting to avoid overwrite."
  exit 1
fi

echo "Generating Ed25519 SSH key for GitHub: $KEY_NAME ($EMAIL)"
ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""

eval "$(ssh-agent -s)" >/dev/null
ssh-add "$KEY_PATH"

PUB_KEY_CONTENT="$(cat "${KEY_PATH}.pub")"

if command -v pbcopy >/dev/null 2>&1; then
  echo "$PUB_KEY_CONTENT" | pbcopy
  echo "Public key copied to clipboard."
else
  echo "pbcopy not found. Public key printed below:"
  echo "$PUB_KEY_CONTENT"
fi

echo "Done. Next steps: add the key to GitHub (Settings → SSH and GPG keys)."


