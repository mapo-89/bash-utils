# 🧰 bash-utils – Globale Bash-Hilfsfunktionen für Projekte

Willkommen bei `bash-utils` – einer Sammlung wiederverwendbarer Bash-Hilfsskripte für Logging, Farbgestaltung, Umgebungsvariablen, Menüs und mehr. Ideal für Shell-Projekte, Systemautomatisierung und DevOps-Tools. 🚀

📖 Diese README ist auch auf [🇬🇧 Englisch](README.md) verfügbar.

## 📦 Installation

```bash
sudo git clone https://github.com/mapo-89/bash-utils.git /usr/local/bin/bash-utils
```

Oder als Submodul im Projekt:

```bash
git submodule add https://github.com/mapo-89/bash-utils utils/bash-utils
```

### 1. **Installationsskript verwenden**

Um `bash-utils` schnell und einfach zu installieren, kannst du das folgende Installationsskript verwenden. Dieses Skript stellt sicher, dass alle Dateien an den richtigen Stellen landen und die Berechtigungen korrekt gesetzt werden.

Führe das Installationsskript mit Root-Rechten aus:

```bash
sudo bash install.sh
```

### 2. **Umgebungsvariablen setzen**

Wenn du das Skript erfolgreich ausgeführt hast, stelle sicher, dass die Umgebungsvariable `BASH_UTILS_DIR` korrekt gesetzt ist. Du kannst sie manuell zu deiner `~/.bashrc` oder `~/.bash_profile` hinzufügen:

```bash
# Set the BASH_UTILS_DIR environment variable to the path where your bash-utils are located.
export BASH_UTILS_DIR='/usr/local/bin/bash-utils'
```

### 3. **Überprüfen der Installation**

Um sicherzustellen, dass `bash-utils` korrekt installiert wurde, kannst du folgendes Kommando ausführen:

```bash
source /usr/local/bin/bash-utils/lib.sh
```

Falls keine Fehlermeldung erscheint, wurde die Installation erfolgreich abgeschlossen.

### 4. **Deinstallation**
Falls du `bash-utils` wieder deinstallieren möchtest, kannst du das folgende Uninstallationsskript verwenden:

Führe das Deinstallationsskript aus:

```bash
sudo bash uninstall.sh
```

### 5. **Testen der Funktionalität**
Nachdem `bash-utils` installiert ist, kannst du die Funktionalität testen, indem du zum Beispiel ein kleines Testskript erstellst, das die `log_*`-Funktionen aus `logging.sh` verwendet.

Beispiel:

```bash
#!/bin/bash
source /usr/local/bin/bash-utils/lib.sh

log_info "Installation von bash-utils erfolgreich!"
```

## 📁 Struktur
```
bash-utils/
├── ui/                # UI-spezifische Skripte
│   ├── layout.sh      # Funktionen für Layout und Textformatierung
│   ├── lines.sh       # Funktionen für Linien und Einzüge
│   └── menu.sh        # Menü-Darstellung und UI-Interaktion
├── colors.sh         # Farbdefinitionen (Text + Hintergrund)
├── env.sh            # .env-Loader + Pflichtvariablen-Prüfung
├── lib.sh            # Haupt-Bibliothek zum Einbinden (Initialisierung)
├── logging.sh        # Logging mit Icons + Farbe + Datei
└── validators.sh     # Validierungsfunktionen (z.B. IP, Port etc.)
```

## 🚀 Verwendung in deinem Projekt
1. Binde `lib.sh` am Anfang deines Skripts ein:
    ```bash
    source /usr/local/bin/bash-utils/lib.sh
    ```
2. Optional: `.env-Datei` ins Projektverzeichnis legen
    ```ini
    # .env
    RAM_LIMIT=80
    ALERT_EMAIL=admin@example.com
    ```
3. Beispielskript mit Logging & Variablen:
    ```bash
    #!/bin/bash
    source /usr/local/bin/bash-utils/lib.sh

    require_var "ALERT_EMAIL" "Bitte in der .env setzen"

    log_info "Starte RAM-Überwachung"
    log_success "E-Mail wird an $ALERT_EMAIL gesendet"
    ```

## 🔍 Module im Detail

### 🎨 colors.sh
Stellt ANSI-Farben als Variablen zur Verfügung:
```bash
echo -e "${GREEN}Erfolg!${NC}"
```

### 📋 logging.sh
Bietet strukturierte Logs mit Symbolen, Farben & Dateiausgabe:
```bash
log_info "System läuft"
log_error "Fehler erkannt"
```

### ⚙ env.sh
Lädt .env-Dateien und prüft auf Pflichtvariablen:
```bash
load_env
require_var "API_KEY" "Fehlender Schlüssel für externen Zugriff"
```

### 🧩 lib.sh
Zentrale Einstiegsdatei, lädt alle anderen Module:
```bash
source /usr/local/bin/bash-utils/lib.sh
```

## ⚙ Konfigurierbare Umgebungsvariablen

| Variable        | Standardwert                     | Beschreibung                                  |
|-----------------|-----------------------------------|-----------------------------------------------|
| BASH_UTILS_DIR  | /usr/local/bin/bash-utils         | Basisverzeichnis der Module                   |
| ROOT_DIR        | Projektverzeichnis                | Nützlich für .env und Logs                    |
| LOG_FILE        | $LOG_DIR/main.log                 | Log-Datei für log_* Funktionen                |
| LOG_DIR         | $ROOT_DIR/logs                    | Verzeichnis für Logs                          |
| SKIP_ENV        | false                             | Wenn true, wird .env nicht geladen            |

## 🧪 Test
```bash
cd test/
bash test_logging.sh
```

## 🧰 Bash-Projektgenerator

Der **Bash-Projektgenerator** hilft dir, schnell eine neue Projektstruktur aufzusetzen. Weitere Informationen findest du in der [Projektgenerator-Dokumentation](PROJECT_GENERATOR.md).


## 🛡 Lizenz
MIT License – Frei verwendbar, auch kommerziell. Keine Garantie.

## ✨ Ideen für die Zukunft
- 📦 Bereitstellung als .deb-Paket
- 🧪 Test-Suite mit Bats
- 🧠 Hilfsfunktionen für Netzwerke, Dateien etc.
- 🔐 Weitere Validatoren (Pfad, JSON, Netzwerk etc.)

## 🤝 Mitwirken
Issues, Pull Requests & Ideen sind willkommen – let’s build together! 🚀

