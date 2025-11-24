#!/bin/bash
# /usr/local/bin/bash-utils-cli

SKIP_ENV="true"
BASH_UTILS_DIR="${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}"
source "$BASH_UTILS_DIR/core/lib.sh"
CLI_DIR="${BASH_UTILS_DIR}/cli"

# Version ausgeben
if [[ "$1" == "--version" ]]; then
    echo "bash-utils $BASH_UTILS_VERSION"
    exit 0
fi

# Update-Funktion
if [[ "$1" == "update" || "$1" == "--update" ]]; then
    UPDATE_SCRIPT="$CLI_DIR/update.sh"

    if [[ -f "$UPDATE_SCRIPT" ]]; then
        echo "🔄 Starte Update..."
        bash "$UPDATE_SCRIPT"
        exit $?
    else
        echo "❌ Fehler: Update-Skript wurde nicht gefunden:"
        echo "   $UPDATE_SCRIPT"
        echo "Bitte stelle sicher, dass bash-utils korrekt installiert ist."
        exit 1
    fi
fi