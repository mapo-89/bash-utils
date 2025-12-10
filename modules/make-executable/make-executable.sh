#!/bin/bash
# modules/make-executable/make-executable.sh
# Macht rekursiv alle Skripte in einem Verzeichnis ausführbar

make_executable() {
    local dir="${1:-.}"         # Standard: aktuelles Verzeichnis
    shift
    local extensions=("$@")     # optionale Extensions (z.B. sh py pl)

    # Standard-Endungen für Skripte
    DEFAULT_EXTENSIONS=(sh bash zsh ksh py pl rb php js ts)

    # Falls keine Endungen übergeben wurden → Standard verwenden
    if [[ ${#extensions[@]} -eq 0 ]]; then
        extensions=("${DEFAULT_EXTENSIONS[@]}")
    fi

    echo "📄 Erlaube folgende Skript-Endungen: ${extensions[*]}"

    # Nur Dateien mit gültiger Endung ausführbar machen
    for ext in "${extensions[@]}"; do
        find "$dir" -type f -name "*.${ext}" | while read -r file; do
            chmod +x "$file"
            echo "✔ $file"
        done
    done
    
    echo "✅ Alle Skripte ausführbar gemacht."
}
