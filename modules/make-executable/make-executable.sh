#!/bin/bash
# modules/make-executable/make-executable.sh
# Macht rekursiv alle Skripte in einem Verzeichnis ausführbar

make_executable() {
    local dir="${1:-.}"         # Standard: aktuelles Verzeichnis
    shift
    local extensions=("$@")     # optionale Extensions (z.B. sh py pl)

    echo "🔧 Durchsuche $dir nach Skripten zum ausführbar machen..."

    if [[ ${#extensions[@]} -eq 0 ]]; then
        find "$dir" -type f | while read -r file; do
            chmod +x "$file"
            echo "✔ $file"
        done
    else
        for ext in "${extensions[@]}"; do
            find "$dir" -type f -name "*.$ext" | while read -r file; do
                chmod +x "$file"
                echo "✔ $file"
            done
        done
    fi

    echo "✅ Alle Skripte ausführbar gemacht."
}
