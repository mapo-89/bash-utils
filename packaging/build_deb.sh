#!/bin/bash
# build_deb.sh – Erzeugt ein Debian-Paket aus bash-utils

# Variablen
PKG_NAME="bash-utils"
PKG_VERSION="$1"
BUILD_DIR=/tmp/${PKG_NAME}-build
INSTALL_PATH="usr/local/bin/$PKG_NAME"

# 1️⃣ Aufräumen
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/DEBIAN"
mkdir -p "$BUILD_DIR/$INSTALL_PATH"

# 2️⃣ Dateien kopieren
echo "📦 Kopiere bash-utils in Paketstruktur..."
cp -r core io ui validation tools test cli lib.sh LICENSE.md README.de.md README.md "$BUILD_DIR/$INSTALL_PATH/"

# 3️⃣ DEBIAN/control erstellen
cat > "$BUILD_DIR/DEBIAN/control" <<EOF
Package: $PKG_NAME
Version: $PKG_VERSION
Section: utils
Priority: optional
Architecture: all
Maintainer: mapo-89 <manuel@postler.de>
Description: Collection of reusable Bash helper functions for logging, colors, menus, validation, and tools such as CRLF-Guardian
Depends: bash (>= 4.0)
EOF

# 4️⃣ postinst Skript erstellen
cat > "$BUILD_DIR/DEBIAN/postinst" <<'EOF'
#!/bin/bash
set -e
TARGET="/usr/local/bin/bash-utils/tools/crlf_guardian.sh"
LINK="/usr/local/bin/crlf-guardian"
if [[ -f "$TARGET" ]]; then
    ln -sf "$TARGET" "$LINK"
    chmod +x "$TARGET"
fi

# === CLI-Wrapper erstellen ===
ln -sf "/usr/local/bin/bash-utils/cli/cli.sh" /usr/local/bin/bash-utils-cli
chmod +x /usr/local/bin/bash-utils-cli

chmod -R 755 /usr/local/bin/bash-utils
chown -R root:root /usr/local/bin/bash-utils
echo "✅ bash-utils installiert, crlf-guardian verfügbar."
EOF
chmod 755 "$BUILD_DIR/DEBIAN/postinst"

# 5️⃣ prerm Skript erstellen
cat > "$BUILD_DIR/DEBIAN/prerm" <<'EOF'
#!/bin/bash
set -e
LINK="/usr/local/bin/crlf-guardian"
if [[ -L "$LINK" ]]; then
    rm -f "$LINK"
fi
EOF
chmod 755 "$BUILD_DIR/DEBIAN/prerm"

# 6️⃣ Paket bauen
dpkg-deb --build "$BUILD_DIR" "${PKG_NAME}_${PKG_VERSION}_all.deb"

#  Aufräumen
rm -rf "$BUILD_DIR"

echo "✅ Paket erstellt: ${PKG_NAME}_${PKG_VERSION}_all.deb"
