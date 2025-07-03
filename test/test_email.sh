#!/bin/bash
# Test script for core/email.sh

# Set the Bash utils directory relative to this file
export BASH_UTILS_DIR="${BASH_UTILS_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"

TEST_EMAIL="$1"

if [[ -z "$TEST_EMAIL" ]]; then
  echo "Usage: $0 recipient@example.com"
  exit 1
fi
export TEST_EMAIL

# Skip directory creation and .env loading for clean test
export SKIP_DIRS=true
export SKIP_ENV=true

# Load core modules
source "$BASH_UTILS_DIR/core/lib.sh"
source "$BASH_UTILS_DIR/core/email.sh"

echo "🔹 Test: send_testmail function"

# Run the function and capture result
if type send_testmail &>/dev/null; then
  send_testmail "$TEST_EMAIL"
  result=$?

  if [[ $result -eq 0 ]]; then
    echo "✅ Testmail successfully sent to $TEST_EMAIL"
  else
    echo "❌ Testmail failed to send"
  fi
else
  echo "❌ send_testmail function not found"
fi
