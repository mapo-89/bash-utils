# Update-Check Modul für bash-utils

Dieses Modul prüft automatisch, ob neue Versionen von bash-utils verfügbar sind.

## Funktionen

- Fragt GitHub Releases ab
- Vergleicht Versionen
- Speichert einen Hinweis in `.update_available`
- CLI zeigt Benachrichtigungen an
- Cronjob prüft alle 12 Stunden automatisch

## Manuelle Prüfung

```bash
bash-utils-cli --update
```