#!/bin/bash

# Installiert einen Cronjob, der alle 12h nach Updates sucht

CRON_FILE="/etc/cron.d/bash-utils-update-check"
CHECK_SCRIPT="/usr/local/bin/bash-utils/modules/update-check/update-check.sh"

if [[ ! -f "$CHECK_SCRIPT" ]]; then
    echo "❌ update-check.sh nicht gefunden! Abbruch."
    exit 1
fi

echo "0 */12 * * * root $CHECK_SCRIPT" | sudo tee "$CRON_FILE" >/dev/null

sudo chmod 644 "$CRON_FILE"

echo "✅ Cronjob installiert: prüft alle 12h auf Updates."
