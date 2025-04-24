[[ "${BASH_SOURCE[0]}" == "${0}" ]] && { echo "❌ Dieses Skript ist eine UI-Bibliothek und nicht direkt ausführbar."; exit 1; }

# utils/ui/layout.sh - Funktionen für Layout und Textformatierung

# Funktion zum Zentrieren von Text
function center_text {
  local text="$1"
  local cols=60
  local text_length=${#text}
  local padding=$(( (cols - text_length) / 2 ))
  printf "%${padding}s%s\n" "" "$text"
}

# Funktion zum Zentrieren von farbigem Text
function center_colored_text {
  local text="$1"
  local color="$2"
  local cols=60
  local text_length=${#text}
  local padding=$(( (cols - text_length) / 2 ))
  printf "%${padding}s${color}%s${NC}\n" "" "$text"
}
