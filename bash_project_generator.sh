#!/bin/bash

# bash_project_generator.sh – Bash-Projektgenerator auf Basis von bash-utils

# Überprüfen, ob bash-utils bereits vorhanden ist
if [ ! -d "/usr/local/bin/bash-utils" ]; then
  echo "❌ bash-utils ist nicht installiert. Bitte installiere es zuerst!"
  exit 1
fi

# Farben und Logging-Module von bash-utils einbinden
source "/usr/local/bin/bash-utils/colors.sh"
source "/usr/local/bin/bash-utils/logging.sh"

# Standardverzeichnisstruktur für das Projekt
ROOT_DIR="$1"
if [ -z "$ROOT_DIR" ]; then
  log_error "Kein Verzeichnis angegeben. Bitte gebe ein Verzeichnis für dein Projekt an."
  exit 1
fi

# Basisstruktur für das Projekt erstellen
mkdir -p "$ROOT_DIR/{bin,src,tests,logs,config}"
mkdir -p "$ROOT_DIR/{bin/scripts,src/modules,tests/unit}"

# .env-Datei erstellen
touch "$ROOT_DIR/.env"
echo "# .env für $ROOT_DIR" > "$ROOT_DIR/.env"
echo "LOG_FILE=$ROOT_DIR/logs/main.log" >> "$ROOT_DIR/.env"
echo "BASH_UTILS_DIR=/usr/local/bin/bash-utils" >> "$ROOT_DIR/.env"
echo "ROOT_DIR=$ROOT_DIR" >> "$ROOT_DIR/.env"
log_success "Erfolgreich .env-Datei erstellt."

# Beispielskripte und -module erstellen
echo "#!/bin/bash" > "$ROOT_DIR/bin/start.sh"
echo "source \$BASH_UTILS_DIR/lib.sh" >> "$ROOT_DIR/bin/start.sh"
echo "log_info 'Projekt gestartet'" >> "$ROOT_DIR/bin/start.sh"
chmod +x "$ROOT_DIR/bin/start.sh"
log_success "Beispiel-Skript 'start.sh' erstellt."

# Beispiel für ein Modul
echo "#!/bin/bash" > "$ROOT_DIR/src/modules/example_module.sh"
echo "log_info 'Beispiel-Modul geladen'" >> "$ROOT_DIR/src/modules/example_module.sh"
chmod +x "$ROOT_DIR/src/modules/example_module.sh"
log_success "Beispiel-Modul 'example_module.sh' erstellt."

# Beispiel für eine Testdatei
echo "#!/bin/bash" > "$ROOT_DIR/tests/unit/test_example.sh"
echo "source \$BASH_UTILS_DIR/lib.sh" >> "$ROOT_DIR/tests/unit/test_example.sh"
echo "log_info 'Test läuft'" >> "$ROOT_DIR/tests/unit/test_example.sh"
chmod +x "$ROOT_DIR/tests/unit/test_example.sh"
log_success "Beispiel-Test 'test_example.sh' erstellt."

# README-Datei erstellen
echo "# $ROOT_DIR – Bash-Projekt" > "$ROOT_DIR/README.md"
echo "Dieses Projekt nutzt bash-utils zur Strukturierung und Verwaltung." >> "$ROOT_DIR/README.md"
echo "### Verzeichnisstruktur:" >> "$ROOT_DIR/README.md"
echo "```" >> "$ROOT_DIR/README.md"
echo "bash-utils/" >> "$ROOT_DIR/README.md"
echo "├── bin/" >> "$ROOT_DIR/README.md"
echo "│   └── start.sh        # Start-Skript des Projekts" >> "$ROOT_DIR/README.md"
echo "├── src/" >> "$ROOT_DIR/README.md"
echo "│   └── modules/        # Projektmodule" >> "$ROOT_DIR/README.md"
echo "├── tests/" >> "$ROOT_DIR/README.md"
echo "│   └── unit/           # Testskripte" >> "$ROOT_DIR/README.md"
echo "├── logs/               # Log-Dateien" >> "$ROOT_DIR/README.md"
echo "├── config/             # Konfigurationsdateien" >> "$ROOT_DIR/README.md"
echo "└── .env                # Umgebungsvariablen" >> "$ROOT_DIR/README.md"
echo "```" >> "$ROOT_DIR/README.md"
log_success "README.md wurde erstellt."

# Abschlussmeldung
log_info "Dein Projekt wurde erfolgreich erstellt! Du kannst jetzt mit der Entwicklung beginnen."
log_info "Starte dein Projekt mit: './bin/start.sh'"
