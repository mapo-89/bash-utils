[[ "${BASH_SOURCE[0]}" == "${0}" ]] && { echo "❌ Dieses Skript ist als Bibliothek gedacht und nicht direkt ausführbar."; exit 1; };

# utils/ui/lines.sh - Funktionen für Linien und Einzüge

# Funktion für eine Trennlinie
function print_line {
  local color="$1"
  echo -e "${color}════════════════════════════════════════════════════════════${NC}"
}

# Funktion mit Leerzeilen
function print_line_new {
  local color="$1"
  print_line "$color"
  echo
}

# Funktion mit Einzug
function indented_echo {
  local text="$1"
  local indent="  "
  echo -e "${indent}${text}"
}
