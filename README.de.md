# 🧰 bash-utils – Globale Bash-Hilfsfunktionen für Projekte

Willkommen bei `bash-utils` – einer Sammlung wiederverwendbarer Bash-Hilfsskripte für Logging, Farbgestaltung, Umgebungsvariablen, Menüs und mehr. Ideal für Shell-Projekte, Systemautomatisierung und DevOps-Tools. 🚀

📖 Diese README ist auch auf [🇬🇧 Englisch](README.md) verfügbar.

## 📦 Installation

```bash
sudo git clone https://github.com/dein-nutzername/bash-utils.git /usr/local/bin/bash-utils
```

Oder als Submodul im Projekt:

```bash
git submodule add https://github.com/dein-nutzername/bash-utils utils/bash-utils
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

## 🛡 Lizenz
MIT License – Frei verwendbar, auch kommerziell. Keine Garantie.

## ✨ Ideen für die Zukunft
- 📦 Bereitstellung als .deb-Paket
- 🧪 Test-Suite mit Bats
- 🧠 Hilfsfunktionen für Netzwerke, Dateien etc.
- 🔐 Weitere Validatoren (Pfad, JSON, Netzwerk etc.)
- 🧰 Bash-Projektgenerator auf Basis von bash-utils

## 🤝 Mitwirken
Issues, Pull Requests & Ideen sind willkommen – let’s build together! 🚀

