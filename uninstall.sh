#!/bin/bash

# Installationsverzeichnis
INSTALL_DIR="/usr/local/bin/bash-utils"

# Überprüfen, ob das Verzeichnis existiert
if [[ ! -d "$INSTALL_DIR" ]]; then
  echo "❌ bash-utils ist nicht installiert."
  exit 1
fi

# Lösche das Verzeichnis
echo "🧹 Deinstalliere bash-utils..."
rm -rf "$INSTALL_DIR"

# Entferne den Symlink
rm -f /usr/local/bin/bash-utils
rm -f /usr/local/bin/bash-utils

echo "✅ bash-utils wurde erfolgreich deinstalliert."
