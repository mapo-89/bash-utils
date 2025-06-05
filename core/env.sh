[[ "${BASH_SOURCE[0]}" == "${0}" ]] && { echo "❌ Dieses Skript ist als Bibliothek gedacht und nicht direkt ausführbar."; exit 1; };

# bash-utils/env.sh - Hilfsfunktionen für den Umgang mit Umgebungsvariablen

# === 🔄 .env-Datei laden ===
load_env() {
  # Standardverzeichnis für die .env-Datei
  local env_file="${ENV_FILE:-$SCRIPT_DIR/.env}"

  if [[ -f "$env_file" ]]; then
    while IFS='=' read -r key value; do
      # Kommentar oder leere Zeile überspringen
      [[ "$key" =~ ^#.*$ || -z "$key" ]] && continue

      # Nur setzen, wenn Variable noch nicht existiert
      if [[ -z "${!key}" ]]; then
        export "$key=$value"
      fi
    done < <(grep -v '^#' "$env_file" | grep '=')

    log_success --no-log "Umgebungsvariablen aus $env_file geladen (bestehende nicht überschrieben)."
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
