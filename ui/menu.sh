[[ "${BASH_SOURCE[0]}" == "${0}" ]] && { echo "❌ Dieses Skript ist als Bibliothek gedacht und nicht direkt ausführbar."; exit 1; };

# utils/ui/menu.sh – Funktionen für Menüs

# Farben zentral laden
source "${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/core/colors.sh"

# Lade alle benötigten UI-Module
source "${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/ui/lines.sh"
source "${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/ui/layout.sh"

# Hauptmenü anzeigen
menu_show() {
  local title="$1"
  shift
  local options=("$@")

  clear
  print_line "${GREEN}"
  center_colored_text "$title" "${GREEN}"
  print_line_new "${GREEN}"
  center_colored_text "Bitte wähle eine der folgenden Optionen:" "${CYAN}"
  print_line_new "${CYAN}"

  # Optionen ausgeben
  for i in "${!options[@]}"; do
    local num=$((i + 1))
    echo -e "${CYAN}${num})${NC} ${options[i]}"
  done
  echo -e "${CYAN}Esc)${NC} ❌  Beenden"
}

# Menü-Eingabe abfragen und validieren
menu_read_choice() {
  local max=$1
  echo -n -e "${CYAN}➡️  Bitte wähle eine Option (1–${max}): ${NC}"
  while true; do
    read -rsn1 choice
    case "$choice" in
      $'\e') echo; return 0 ;;  # Esc = abbrechen
      [1-9])
        if (( choice <= max )); then
          echo "$choice"
          return 1
        else
          echo -e "\n${RED}Ungültige Auswahl! Bitte Zahl zwischen 1 und $max eingeben.${NC}"
          echo -n -e "${CYAN}➡️  Bitte wähle eine Option (1–${max}): ${NC}"
        fi
        ;;
      *)
        echo -e "\n${RED}Ungültige Eingabe!${NC}"
        echo -n -e "${CYAN}➡️  Bitte wähle eine Option (1–${max}): ${NC}"
        ;;
    esac
  done
}

# Menü loop starten mit Optionen & Funktionen
menu_loop() {
  local title="$1"
  shift
  local -n opts=$1    # Array mit Optionstexten
  local -n actions=$2 # Array mit Funktionsnamen oder Befehlen

  while true; do
    menu_show "$title" "${opts[@]}"
    local choice
    menu_read_choice "${#opts[@]}"
    # Wenn Esc gedrückt (leer) abbrechen
    if [[ -z "$choice" ]]; then
      echo -e "${RED}❌  Beenden...${NC}"
      break
    fi
    local idx=$((choice - 1))
    local action="${actions[idx]}"

    # Loggen, wenn LOG_FILE definiert
    if [[ -n "$LOG_FILE" ]]; then
      echo "[$(date "+%Y-%m-%d %H:%M:%S")] START: ${opts[idx]}" >> "$LOG_FILE"
    fi

    # Aktion ausführen (als Funktion oder Kommando)
    if declare -F "$action" > /dev/null; then
      "$action"
    else
      eval "$action"
    fi

    echo
    read -rp "🔁  Drücke [Enter] um fortzufahren..." dummy
  done
}