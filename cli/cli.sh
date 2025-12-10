#!/bin/bash
# /usr/local/bin/bash-utils-cli

SKIP_ENV="true"
SKIP_DIRS="true"
BASH_UTILS_DIR="${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}"
source "$BASH_UTILS_DIR/core/lib.sh"
CLI_DIR="${BASH_UTILS_DIR}/cli"
CACHE_DIR="$HOME/.cache/bash-utils"
NOTIFY_FILE="$CACHE_DIR/update_available"

if [[ -f "$NOTIFY_FILE" ]]; then
    NEW_VERSION=$(cat "$NOTIFY_FILE")
    echo "🔔 Update verfügbar: bash-utils $NEW_VERSION"
    echo "👉 Installieren mit: bash-utils-cli --update"
fi

# Version ausgeben
if [[ "$1" == "--version" ]]; then
    echo "bash-utils $BASH_UTILS_VERSION"
    exit 0
fi

if [[ "$1" == "make-executable" || "$1" == "--make-executable" ]]; then
    source "$BASH_UTILS_DIR/modules/make-executable/make-executable.sh"
    shift
    make_executable "$@"
    exit 0
fi

# --- 🔄 Update-Funktion -------------------------------------------------------
if [[ "$1" == "update" || "$1" == "--update" ]]; then
    UPDATE_SCRIPT="$CLI_DIR/update.sh"
    CHECK_SCRIPT="$BASH_UTILS_DIR/modules/update-check/update-check.sh"

    # Prüfen ob der Update-Checker existiert
    if [[ ! -f "$CHECK_SCRIPT" ]]; then
        echo "❌ Fehler: Update-Check-Skript fehlt:"
        echo "   $CHECK_SCRIPT"
        exit 1
    fi

    # Update prüfen
    bash "$CHECK_SCRIPT"

    if [[ -f "$NOTIFY_FILE" ]]; then
        NEW_VERSION=$(cat "$NOTIFY_FILE")
        echo "⬆️ Update verfügbar: $LOCAL_VERSION → $NEW_VERSION"

        # Nutzer fragen
        read -rp "Möchtest du das Update jetzt installieren? [y/N]: " answer
        case "$answer" in
            y|Y|yes|YES)
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
                ;;
            *)
                echo "🚫 Update abgebrochen."
                exit 0
                ;;
        esac

    else
        echo "✔ bash-utils ist aktuell"
        exit 0
    fi
fi