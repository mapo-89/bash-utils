#!/bin/bash

# Installationsverzeichnis (kann angepasst werden)
INSTALL_DIR="/usr/local/bin/bash-utils"

# Überprüfen, ob das Skript mit root-Rechten ausgeführt wird
if [[ "$EUID" -ne 0 ]]; then
  echo "❌ Bitte das Skript als Root ausführen (sudo)."
  exit 1
fi

# Der Pfad zum aktuellen Verzeichnis (wo das Skript liegt)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Erstelle das Installationsverzeichnis
echo "🔧 Installiere bash-utils..."
mkdir -p "$INSTALL_DIR"

# Alle Dateien in das Installationsverzeichnis kopieren
echo "📦 Dateien werden kopiert..."
cp -r "$SCRIPT_DIR/"* "$INSTALL_DIR/"

# Setze die richtigen Berechtigungen
echo "🔒 Berechtigungen werden gesetzt..."
chmod -R 755 "$INSTALL_DIR"
chown -R root:root "$INSTALL_DIR"

# Überprüfen, ob die Installation erfolgreich war
if [[ -f "$INSTALL_DIR/lib.sh" ]]; then
  echo "✅ bash-utils erfolgreich installiert."
else
  echo "❌ Installation fehlgeschlagen."
  exit 1
fi

echo "🚀 Installation abgeschlossen. Du kannst jetzt bash-utils verwenden."
