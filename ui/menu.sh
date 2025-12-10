[[ "${BASH_SOURCE[0]}" == "${0}" ]] && { echo "❌ Dieses Skript ist als Bibliothek gedacht und nicht direkt ausführbar."; exit 1; };

# utils/ui/menu.sh – Funktionen für Menüs

# Farben zentral laden
source "${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/core/colors.sh"

# Lade alle benötigten UI-Module
source "${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/ui/lines.sh"
source "${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/ui/layout.sh"

# === Menü anzeigen ===
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

# === Auswahl auswerten ===
menu_read_choice() {
  local max=$1
  local choice=$2
  
    case "$choice" in
      $'\e') echo; return 0 ;;  # Esc = abbrechen
      [1-9])
        if (( choice <= max )); then
          echo $choice
          exit 0
        else
          echo -e "\n${RED}Ungültige Auswahl! Bitte Zahl zwischen 1 und $max eingeben. Menü wird neu geladen...${NC}"
          return 0
        fi
        ;;
      *)
        echo -e "\n${RED}Ungültige Eingabe! Menü wird neu geladen...${NC}"
        return 0
        ;;
    esac
}

# Menü loop starten mit Optionen & Funktionen
menu_loop() {
  local title="$1"
  shift
  local -n opts=$1    # Array mit Optionstexten
  local -n actions=$2 # Array mit Funktionsnamen oder Befehlen
  local max="${#opts[@]}"

  while true; do
    menu_show "$title" "${opts[@]}"

    local firstchoice
    echo -n -e "${CYAN}➡️  Bitte wähle eine Option (1–$max): ${NC}"
     # Wenn Esc gedrückt (leer) abbrechen
    read -rsn1 first
    if [[ "$first" == $'\e' ]]; then
      echo -e "\n${RED}👋  Beenden...${NC}"
      return 0
    fi
    echo -n "$first"  # Sichtbar machen
    read -r rest      # Rest der Eingabe
    local firstchoice="${first}${rest}"
    
    choice=$(menu_read_choice "$max" "${firstchoice}")
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > max )); then
      echo $choice
      sleep 1
      continue
    fi

    local idx=$((choice - 1))
    local action="${actions[idx]}"
    local label="${opts[idx]}"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    echo

    [[ -n "$LOG_FILE" ]] && echo "[$timestamp] START: $label" >> "$LOG_FILE"

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