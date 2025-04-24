[[ "${BASH_SOURCE[0]}" == "${0}" ]] && { echo "❌ Dieses Skript ist als Bibliothek gedacht und nicht direkt ausführbar."; exit 1; };

# bash-utils/env.sh - Hilfsfunktionen für den Umgang mit Umgebungsvariablen

# === 🔄 .env-Datei laden ===
load_env() {
  local default_dir="$(dirname "${BASH_UTILS_DIR:-$SCRIPT_DIR}")"
  local env_file="${ENV_FILE:-$default_dir/.env}"

  if [[ -f "$env_file" ]]; then
    set -o allexport
    source "$env_file"
    set +o allexport
    log_success --no-log "Umgebungsvariablen aus $env_file geladen."
  else
    if [[ "$ENV_REQUIRED" == "true" ]]; then
      log_error --no-log ".env-Datei $env_file nicht gefunden."
      exit 1
    else
      log_warning --no-log ".env-Datei $env_file nicht gefunden, lade trotzdem fort."
    fi
  fi
}

# === ❗ Pflichtvariable prüfen ===
require_var() {
  local var_name="$1"
  local description="$2"
  local value="${!var_name}"

  if [ -z "$value" ]; then
    log_error "$var_name ist nicht gesetzt. $description"
    exit 1
  fi
}
