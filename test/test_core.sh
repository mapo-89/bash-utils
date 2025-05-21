#!/bin/bash
# ✅ Unit Test für core-Module (logging, colors etc.)

# Testkontext konfigurieren
SKIP_DIRS="true"
SKIP_ENV="true"
export BASH_UTILS_DIR="${BASH_UTILS_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"

# Lade die Hauptbibliothek
source "$BASH_UTILS_DIR/core/lib.sh"

# Helferfunktionen für Statusausgabe
print_header()  { 
    echo -e "\n${BLUE}🔹 $1${NC}"; 
}

# === Tests ===

print_header "Test: core/logging"

if type log_success &>/dev/null; then
  log_success --no-log "Simulated success message"
  log_success --no-log "log_success available and usable"
else
  log_error --no-log "log_success function not found"
fi

echo

if type log_info &>/dev/null; then
  log_info --no-log "Simulated info message"
  log_success --no-log "log_success available and usable"
else
  log_error --no-log "log_success function not found"
fi

echo

if type log_error &>/dev/null; then
  log_error --no-log "Simulated error message"
  log_success --no-log "log_error available and usable"
else
  log_error --no-log "log_error function not found"
fi

print_header "Test: core/colors"

if [[ -n "$GREEN" && -n "$NC" && -n "$RED" && -n "$CYAN" ]]; then
  echo -e "${GREEN}This is green${NC}, ${RED}this is red${NC}, ${CYAN}this is cyan${NC}"
  log_success --no-log "Color variables are defined"
else
  log_error --no-log "One or more color variables are missing"
fi
