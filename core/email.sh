[[ "${BASH_SOURCE[0]}" == "${0}" ]] && { echo "❌ Dieses Skript ist als Bibliothek gedacht und nicht direkt ausführbar."; exit 1; };

# bash-utils/core/email.sh - E-Mail-Funktionen

# === 📧 Sende eine Testmail mit UTF-8-Encoding über msmtp ===
send_testmail() {
  local recipient="${1:-$TEST_EMAIL}"

  if [[ -z "$recipient" ]]; then
    log_error "Kein Empfänger angegeben (TEST_EMAIL ist leer)."
    return 1
  fi

  local hostname="$(hostname)"
  local subject="Testmail von $hostname"
  local body="Dies ist eine Testmail über msmtp."

  printf "%s\n" \
    "To: ${recipient}" \
    "Subject: ${subject}" \
    "Content-Type: text/plain; charset=UTF-8" \
    "Content-Transfer-Encoding: 8bit" \
    "" \
    "$body" | msmtp "$recipient"

  if [[ $? -eq 0 ]]; then
    log_success "📨 Testmail erfolgreich gesendet an $recipient."
  else
    log_error "Testmail konnte nicht gesendet werden an $recipient."
    return 1
  fi
}
