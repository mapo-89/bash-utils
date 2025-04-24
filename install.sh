#!/bin/bash

# Installationsverzeichnis (kann angepasst werden)
INSTALL_DIR="/usr/local/bin/bash-utils"

# Überprüfen, ob das Skript mit root-Rechten ausgeführt wird
if [[ "$EUID" -ne 0 ]]; then
  echo "❌ Bitte das Skript als Root ausführen (sudo)."
  exit 1
fi

# Erstelle das Installationsverzeichnis
echo "🔧 Installiere bash-utils..."
mkdir -p "$INSTALL_DIR"

# Alle Dateien in das Installationsverzeichnis kopieren
echo "📦 Dateien werden kopiert..."
cp -r ./bash-utils/* "$INSTALL_DIR/"

# Setze die richtigen Berechtigungen
echo "🔒 Berechtigungen werden gesetzt..."
chmod -R 755 "$INSTALL_DIR"
chown -R root:root "$INSTALL_DIR"

# Sicherstellen, dass die lib.sh im Systempfad verfügbar ist
echo "🔧 Füge bash-utils zum Systempfad hinzu..."
ln -sf "$INSTALL_DIR/lib.sh" /usr/local/bin/bash-utils

# Überprüfen, ob die Installation erfolgreich war
if [[ -f "$INSTALL_DIR/lib.sh" ]]; then
  echo "✅ bash-utils erfolgreich installiert."
else
  echo "❌ Installation fehlgeschlagen."
  exit 1
fi

echo "🚀 Installation abgeschlossen. Du kannst jetzt bash-utils verwenden."
