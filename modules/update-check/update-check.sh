#!/bin/bash

# Automatischer Update-Checker für bash-utils
# Prüft GitHub Releases und schreibt Info-Dateien für die CLI
SKIP_ENV="true"
SKIP_DIRS="true"
BASH_UTILS_DIR="${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}"
LOCAL_VERSION_FILE="$BASH_UTILS_DIR/.version"
NOTIFY_FILE="$BASH_UTILS_DIR/.update_available"

LOCAL_VERSION=$(cat "$LOCAL_VERSION_FILE" 2>/dev/null || echo "0.0.0")

LATEST_VERSION=$(curl -s "https://api.github.com/repos/mapo-89/bash-utils/releases/latest" | grep '"tag_name":' | head -n1 | cut -d '"' -f4)

if [[ -z "$LATEST_VERSION" ]]; then
    exit 0
fi

# Version vergleichen
if dpkg --compare-versions "$LATEST_VERSION" gt "$LOCAL_VERSION"; then
    echo "$LATEST_VERSION" > "$NOTIFY_FILE"
else
    rm -f "$NOTIFY_FILE"
fi
