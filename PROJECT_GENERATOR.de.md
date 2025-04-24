# 🧰 Bash-Projektgenerator

Der **Bash-Projektgenerator** erleichtert das schnelle Erstellen eines neuen Bash-Projekts. Er erstellt die grundlegende Verzeichnisstruktur, konfiguriert eine `.env`-Datei und fügt Beispielskripte sowie Testskripte hinzu. Dies ermöglicht eine standardisierte und zeitsparende Erstellung eines neuen Projekts.

## 🚀 Nutzung des Projektgenerators

1. Lade das **Bash-Projektgenerator-Skript** herunter: Stelle sicher, dass du Zugriff auf das Skript hast, um den Generator auszuführen.

2. Führe den Generator aus, indem du den Namen des Verzeichnisses angibst, in dem das Projekt erstellt werden soll:

```bash
./bash_project_generator.sh /path/to/my-new-project
```

## 🔧 Funktionen des Projektgenerators

Der Projektgenerator erstellt die folgende Struktur für dein neues Projekt:

```bash
my-new-project/
├── bin/                # Ausführbare Skripte
│   └── start.sh        # Beispiel-Skript zum Starten des Projekts
├── src/                # Quellcode und Module
│   └── modules/        # Beispiel-Modul
├── tests/              # Testskripte
│   └── unit/           # Beispiel-Test
├── logs/               # Log-Dateien
├── config/             # Konfigurationsdateien
├── .env                # Umgebungsvariablen
└── README.md           # Dokumentation

```

## 📜 Beispielskripte

- **start.sh:** Ein einfaches Skript, das den Start deines Projekts simuliert.

- **example_module.sh:** Ein Beispielmodul, das in dein Projekt eingebunden werden kann.

- **test_example.sh:** Ein einfacher Test, um das Setup zu überprüfen.


## 📄 README.md

Der Generator erstellt auch eine `README.md` mit einer kurzen Einführung in dein Projekt sowie der Verzeichnisstruktur.


## 🧪 Beispiel

Nachdem der Generator das Projekt erstellt hat, kannst du das Projekt starten:

```bash
./bin/start.sh
```