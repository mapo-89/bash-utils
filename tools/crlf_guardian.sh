#!/bin/bash
# crlf-guardian – Automatische Erkennung & Reparatur von CRLF-Zeilenenden
# Integration für bash-utils

# Wenn über Symlink aufgerufen, realen Pfad ermitteln
SCRIPT_PATH="$(readlink -f "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# bash-utils Basisverzeichnis automatisch aus dem Tools-Ordner ableiten
AUTO_UTILS_DIR="$(dirname "$SCRIPT_DIR")"   # tools/.. → bash-utils/

# Wenn BASH_UTILS_DIR nicht gesetzt ist → automatisch setzen
if [[ -z "$BASH_UTILS_DIR" ]]; then
    export BASH_UTILS_DIR="$AUTO_UTILS_DIR"
fi

# Prüfen, ob lib.sh existiert
if [[ ! -f "$BASH_UTILS_DIR/core/lib.sh" ]]; then
    echo "❌ FATAL: Konnte bash-utils nicht finden!"
    echo "Erwartet unter: $BASH_UTILS_DIR/core/lib.sh"
    exit 1
fi

SKIP_ENV="true"
# Kernmodule laden
source "$BASH_UTILS_DIR/core/lib.sh"

# --- Konfiguration ---
SCAN_EXTENSIONS=("*.sh" "*.env" "*.conf" "*.yml" "*.yaml" "*.json" "*.txt")

# --- Funktionen ---

scan_for_crlf() {
    local file="$1"

    if grep -q $'\r' "$file"; then
        log_warn "CRLF gefunden: $file"
        return 1
    fi

    log_debug "OK: $file"
    return 0
}

fix_crlf() {
    local file="$1"

    if grep -q $'\r' "$file"; then
        sed -i 's/\r$//' "$file"
        log_success "Fix angewendet: $file"
    else
        log_debug "Keine Änderungen notwendig: $file"
    fi
}

scan_directory() {
    local dir="$1"
    log_info "Scanne nach CRLF in: $dir"

    for ext in "${SCAN_EXTENSIONS[@]}"; do
        while IFS= read -r file; do
            scan_for_crlf "$file"
        done < <(find "$dir" -type f -name "$ext")
    done
}

fix_directory() {
    local dir="$1"
    log_info "Fixe CRLF in: $dir"

    for ext in "${SCAN_EXTENSIONS[@]}"; do
        while IFS= read -r file; do
            fix_crlf "$file"
        done < <(find "$dir" -type f -name "$ext")
    done
}

# --- CLI Interface ---

case "$1" in
    scan)
        scan_directory "${2:-.}"
        ;;
    fix)
        fix_directory "${2:-.}"
        ;;
    ""|help|--help|-h)
        echo "crlf-guardian — Detect & Fix CRLF"
        echo ""
        echo "Usage:"
        echo "  crlf-guardian scan [dir]"
        echo "  crlf-guardian fix [dir]"
        ;;
    *)
        log_error "Unbekannter Befehl: $1"
        exit 1
        ;;
esac
