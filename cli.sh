#!/bin/bash
# /usr/local/bin/bash-utils-cli

SKIP_ENV="true"
BASH_UTILS_DIR="${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}"
source "$BASH_UTILS_DIR/core/lib.sh"

# Version ausgeben
if [[ "$1" == "--version" ]]; then
    echo "bash-utils $BASH_UTILS_VERSION"
    exit 0
fi

