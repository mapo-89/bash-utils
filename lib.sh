#!/bin/bash

# Bash-Utils laden, falls nötig
BASH_UTILS_UI_DIR="${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/ui"
source "$BASH_UTILS_UI_DIR/layout.sh"
source "$BASH_UTILS_UI_DIR/lines.sh"
source "$BASH_UTILS_DIR/core/colors.sh"

clear
print_line "${YELLOW}"
center_colored_text "⚠️  Hinweis: Veralteter Einstiegspunkt" "${YELLOW}"
print_line_new "${YELLOW}"

center_colored_text "Die Datei 'lib.sh' wurde verschoben." "${NV}"
center_colored_text "Bitte verwende ab sofort:" "${NV}"
echo
center_colored_text "➡️  core/lib.sh" "${GREEN}"
echo
center_colored_text "Passe dein Skript wie folgt an:" "${MAGENTA}"
center_colored_text 'source ${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}/core/lib.sh' "${CYAN}"
print_line_new "${YELLOW}"

exit 1
