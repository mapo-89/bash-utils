#!/bin/bash
# Test script to verify that bash-utils modules load without errors

# Set BASH_UTILS_DIR to current repo if not set
export BASH_UTILS_DIR="${BASH_UTILS_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"

source "$BASH_UTILS_DIR/core/lib.sh"

echo "Testing core functions..."

# Test log_info from logging.sh
log_info "✅ log_info function works"

# Test color variables from colors.sh
echo -e "${GREEN}✅ Colors loaded${NC}"

# Test validator function (assuming you have is_ip function)
if type is_ip &>/dev/null; then
  if is_ip "192.168.1.1"; then
    echo "✅ Validator function is_ip works"
  else
    echo "❌ Validator function is_ip failed"
  fi
else
  echo "ℹ️ Validator function is_ip not found"
fi

echo
echo "Loading UI menu functions..."

# Load UI menu module (which itself loads layout.sh and lines.sh)
source "$BASH_UTILS_DIR/ui/menu.sh"

# Test if menu_show (or another UI function) exists and call it with a simple menu
if type menu_show &>/dev/null; then
  echo "✅ menu_show function found, displaying sample menu:"
  
  options=(
    "Subdomain generieren"
    "Peer zu WireGuard hinzufügen"
    "Beenden"
    )
    actions=(
    "subdomain_generate"
    "add_wireguard_peer"
    "exit_script"
    )

    menu_loop "Willkommen zur Skript-Auswahl!" options actions
  
else
  echo "❌ menu_show function not found"
fi

echo
echo "All tests completed."