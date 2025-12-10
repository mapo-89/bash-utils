# 🛠️ Make Executable Modul für bash-utils

ermöglicht es, alle Skripte in einem Verzeichnis und dessen Unterordnern automatisch ausführbar zu machen. Es unterstützt optional die Angabe von Dateiendungen (z.B. `.sh`, `.py`, `.pl`) oder kann alle Dateien prüfen.

## ✨ Funktionen

- 🔍 Rekursives Durchsuchen von Ordnern nach Skripten
- 🛠️ Setzt automatisch chmod +x
- 📂 Optional: Filterung nach Dateiendung
- 🚀 Vollständig CLI-integriert über bash-utils-cli
- 🧩 Modular und optional – kann unabhängig vom Kernsystem genutzt werden

## 🚀 Verwendung


- Modul einbinden (Skript)

```bash
source "$BASH_UTILS_DIR/modules/make-executable/make-executable.sh"

# Alle Skripte im Verzeichnis /srv/scripts ausführbar machen
make_executable "/srv/scripts"

# Nur Dateien mit bestimmten Endungen
make_executable "/srv/scripts" sh py pl
```

- CLI nutzen

```bash
# Alle Skripte im Verzeichnis ausführbar machen
bash-utils-cli make-executable /srv/scripts

# Nur Dateien mit bestimmten Endungen
bash-utils-cli make-executable /srv/scripts sh py
```

## 🔧 Optionen

| Parameter        | Beschreibung                      |
|------------------|-----------------------------------|
| `<dir>`            | Zielverzeichnis für das Skript    |
| `[ext...]`	       | Optional: Liste von Dateiendungen (z. B. sh, py) |