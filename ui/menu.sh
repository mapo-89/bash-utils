[[ "${BASH_SOURCE[0]}" == "${0}" ]] && { echo "❌ Dieses Skript ist als Bibliothek gedacht und nicht direkt ausführbar."; exit 1; };

# utils/ui/menu.sh – Funktionen für Menüs

# Farben zentral laden
source "${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/colors.sh"

# Lade alle benötigten UI-Module
source "${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/ui/lines.sh"
source "${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/ui/layout.sh"