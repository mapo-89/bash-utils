[[ "${BASH_SOURCE[0]}" == "${0}" ]] && { echo "❌ Dieses Skript ist als Bibliothek gedacht und nicht direkt ausführbar."; exit 1; };

# lib.sh – Zentrale Initialisierung und Helfer

# 🧭 Verzeichnis der Bash-Utils (default: /usr/local/bin/bash-utils)
BASH_UTILS_DIR="${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}"

# 🔗 Module laden
# Core-Funktionen
source "$BASH_UTILS_DIR/core/colors.sh"
source "$BASH_UTILS_DIR/core/logging.sh"
source "$BASH_UTILS_DIR/core/env.sh"

# Validierung
source "$BASH_UTILS_DIR/validation/validators.sh"

# IO-Helfer
source "$BASH_UTILS_DIR/io/file_helpers.sh"

# 📁 Standardverzeichnisse initialisieren (falls gesetzt)
SCRIPTS_DIR="${SCRIPTS_DIR:-$SCRIPT_DIR/scripts}"
LOG_DIR="${LOG_DIR:-$SCRIPT_DIR/logs}"
mkdir -p "$SCRIPTS_DIR" "$LOG_DIR"

# 📝 Log-Datei setzen (ggf. vom Projekt überschreibbar)
LOG_FILE="${LOG_FILE:-$LOG_DIR/main.log}"
mkdir -p "$(dirname "$LOG_FILE")"

# 🌍 .env-Datei laden (sofern gewünscht)
[[ "$SKIP_ENV" != "true" ]] && load_env