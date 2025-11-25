#!/bin/bash

# Automatischer Update-Checker für bash-utils
# Prüft GitHub Releases und schreibt Info-Dateien für die CLI
SKIP_ENV="true"
SKIP_DIRS="true"
BASH_UTILS_DIR="${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}"
CACHE_DIR="$HOME/.cache/bash-utils"
NOTIFY_FILE="$CACHE_DIR/update_available"
mkdir -p "$CACHE_DIR"

LATEST=$(curl -s "https://api.github.com/repos/mapo-89/bash-utils/releases/latest" | grep '"tag_name":' | head -n1 | cut -d '"' -f4)

if [[ -z "$LATEST" ]]; then
    exit 0
fi

LATEST_VERSION="${LATEST#v}"

# Version vergleichen
if dpkg --compare-versions "$LATEST_VERSION" gt "$BASH_UTILS_VERSION"; then
    echo "$LATEST_VERSION" > "$NOTIFY_FILE"
else
    rm -f "$NOTIFY_FILE"
fi
