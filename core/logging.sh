[[ "${BASH_SOURCE[0]}" == "${0}" ]] && { echo "❌ Dieses Skript ist als Bibliothek gedacht und nicht direkt ausführbar."; exit 1; };

# utils/logging.sh – Logging-Funktionen

# Farben laden (zentraler Pfad, global nutzbar)
source "${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/core/colors.sh"

# ==== Konfiguration ====
LOG_LEVEL="${LOG_LEVEL:-debug}"   # Mögliche Werte: debug, info, warning, error

# ==== Level-Prioritäten (für Filter) ====
declare -A levels=( [debug]=0 [info]=1 [warning]=2 [error]=3 )

# Entfernt ANSI-Farbcodes
strip_colors() {
  sed 's/\x1B\[[0-9;]*[mK]//g'
}

# Generische Log-Funktion
log() {
  local type="$1"; shift

  [[ "${levels[$type]}" -lt "${levels[$LOG_LEVEL]}" ]] && return  # Level-Filter

  # Optionales Flag: --no-log → nicht in LOG_FILE schreiben
  [[ "$1" == "--no-log" ]] && { local log=false; shift; } || log=true

  # Definition der Icons, Farben und Textfarben basierend auf Log-Typ
  declare -A icons=( [info]="ℹ️" [success]="✅" [warning]="⚠️" [error]="❌" [debug]="🔍" )
  declare -A colors=( [info]="$BLUE" [success]="$GREEN" [warning]="$YELLOW" [error]="$RED" [debug]="$CYAN" )
  declare -A textcolors=( [info]="$DARK_GRAY" [success]="$WHITE" [warning]="$YELLOW" [error]="$MAGENTA" [debug]="$LIGHT_GRAY" )

  local icon="${icons[$type]}"
  local color="${colors[$type]}"
  local textcolor="${textcolors[$type]}"
  local label="" && [[ "$type" == "error" ]] && label="Fehler:"

  # Formatierte Nachricht
  local msg="${color}${icon}  ${label:+$label }${textcolor}$*${NC}"
  echo -e "$msg"
  
  # Wenn LOG_FILE gesetzt ist und Logging aktiv → in Datei schreiben
  if [[ -n "$LOG_FILE" && "$log" = true ]]; then
    echo -e "$msg" | strip_colors >> "$LOG_FILE"
  fi
}

# Kurzfunktionen
log_info()    { log info "$@"; }
log_success() { log success "$@"; }
log_warning() { log warning "$@"; }
log_error()   { log error "$@"; }
log_debug()   { log debug "$@"; }
