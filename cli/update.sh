#!/bin/bash
# update.sh – Installiert automatisch die aktuellste bash-utils Version

REPO="mapo-89/bash-utils"
ARCH="all" 
TMP_DIR=$(mktemp -d)

SKIP_ENV="true"
SKIP_DIRS="true"
BASH_UTILS_DIR="${BASH_UTILS_DIR:-/usr/local/bin/bash-utils}"
source "$BASH_UTILS_DIR/core/lib.sh"

echo "🔎 Prüfe auf Updates..."
# Versuche erst GitHub CLI
if command -v gh &> /dev/null; then
    LATEST=$(gh release list --repo "$REPO" | head -n1 | awk '{print $1}')
else
    # Fallback auf GitHub API via curl
    LATEST=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name":' | head -n1 | cut -d '"' -f4)
fi

if [[ -z "$LATEST" ]]; then
    echo "❌ Keine Release-Version gefunden!"
    exit 1
fi

LATEST_VERSION="${LATEST#v}"

echo "📌 Installierte Version: $BASH_UTILS_VERSION"
echo "📌 Aktuellste Version: $LATEST_VERSION"

if dpkg --compare-versions "$BASH_UTILS_VERSION" "ge" "$LATEST_VERSION"; then
    echo "✔️ Du verwendest bereits die neueste oder eine neuere Version."
    exit 0
fi

echo "⬆️ Update verfügbar: $LOCAL_VERSION → $LATEST_VERSION"

# Download und Installation
DEB_FILE="bash-utils_${LATEST#v}_$ARCH.deb"
URL="https://github.com/$REPO/releases/download/$LATEST/$DEB_FILE"

echo "⬇️ Lade $DEB_FILE..."
curl -L -o "$TMP_DIR/$DEB_FILE" "$URL"

echo "📦 Installiere $DEB_FILE..."
sudo dpkg -i "$TMP_DIR/$DEB_FILE" || sudo apt-get install -f -y

echo "✅ bash-utils auf Version $LATEST_VERSION aktualisiert." 

# Aufräumen
rm -rf "$TMP_DIR"
