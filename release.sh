#!/bin/bash
# release.sh – Komplettes Release-Skript für bash-utils

set -e

# 0️⃣ Prüfen, ob GitHub CLI installiert ist
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) nicht installiert. Bitte installieren: https://cli.github.com/"
    exit 1
fi

# 1️⃣ Prüfen, ob auf main/master Branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "$BRANCH" != "main" && "$BRANCH" != "master" ]]; then
    echo "❌ Bitte auf main/master Branch ausführen!"
    exit 1
fi

# 2️⃣ Letzten Git-Tag ermitteln
LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")

# 3️⃣ Neue Version eingeben
read -p "Neue Version (SemVer, z.B. 1.2.0): " NEW_VERSION
NEW_TAG="v$NEW_VERSION"

if git rev-parse "$NEW_TAG" >/dev/null 2>&1; then
    echo "❌ Tag $NEW_TAG existiert bereits!"
    exit 1
fi

# 4️⃣ Changelog aktualisieren (nach Commit-Typ gruppieren)
CHANGELOG="CHANGELOG.md"
echo "## [$NEW_VERSION] - $(date +%Y-%m-%d)" >> "$CHANGELOG"
echo "" >> "$CHANGELOG"

# Commit-Typen → Changelog-Kategorien
declare -A TYPES=(
    # Added
    ["✨ Feature:"]="Added"
    ["🛠️ Tool:"]="Added"
    ["🗃️ DB:"]="Added"
    ["🛣️ Routes:"]="Added"
    ["💄 UI:"]="Added"
    # Changed
    ["♻️ Refactoring:"]="Changed"
    ["🔤 Text:"]="Changed"
    ["🎨 Styling:"]="Changed"
    # Deprecated
    ["⚠️ Deprecated:"]="Deprecated"
    # Removed
    ["🔥 Remove:"]="Removed"
    ["🚚 Move:"]="Removed"
    # Fixed
    ["🐛 Fix:"]="Fixed"
    ["🚑 Hotfix:"]="Fixed"
    # Security
    ["🔒 Security:"]="Security"
    ["🛡️ Security:"]="Security"
    # Performance / Logging
    ["⚡️ Performance:"]="Performance"
    ["📊 Logs:"]="Performance"
    # Documentation
    ["📝 Docs:"]="Documentation"
    ["📚 Docs:"]="Documentation"
    ["🌐 i18n:"]="Documentation"
    # Chore / Config
    ["🔧 Chore:"]="Chore"
    ["📦 Deps:"]="Chore"
    ["⬆️ Deps:"]="Chore"
    ["⬇️ Deps:"]="Chore"
    # Deployment / Release
    ["🚀 Deploy:"]="Deployment"
    ["🔖 Release:"]="Deployment"
    # Miscellaneous
    ["🎉 Init:"]="Miscellaneous"
    ["✏️ Typo:"]="Miscellaneous"
    ["🙈 Gitignore:"]="Miscellaneous"
    ["🔀 Merge:"]="Miscellaneous"
)

# Commits nach Typ sortieren
for EMOJI in "${!TYPES[@]}"; do
    TYPE_NAME=${TYPES[$EMOJI]}
    COMMITS=$(git log "$LAST_TAG"..HEAD --pretty=format:"%s" | grep "^$EMOJI" || true)
    if [[ -n "$COMMITS" ]]; then
        echo "### $TYPE_NAME" >> "$CHANGELOG"
        while IFS= read -r COMMIT; do
            # Emoji entfernen
            MESSAGE=$(echo "$COMMIT" | sed -E "s/^$EMOJI[[:space:]]*//")
            echo "- $MESSAGE" >> "$CHANGELOG"
        done <<< "$COMMITS"
        echo "" >> "$CHANGELOG"
    fi
done


git add "$CHANGELOG"
git commit -m "📝 Docs: update CHANGELOG for $NEW_TAG"

# 5️⃣ Git-Tag setzen und pushen
git tag -a "$NEW_TAG" -m "Release $NEW_TAG"
git push origin "$BRANCH" --tags
git push origin "$BRANCH"

echo "✅ Git-Tag $NEW_TAG gesetzt und Changelog aktualisiert."

# 6️⃣ GitHub Release erstellen (falls noch nicht vorhanden)
REPO=$(git remote get-url origin | sed -E 's/.*[:\/]([^\/]+\/[^\/]+)(\.git)?/\1/')
if ! gh release view "$NEW_TAG" --repo "$REPO" &> /dev/null; then
    NOTES=$(awk "/^## \\[${NEW_VERSION}\\]/ {flag=1; next} /^## \\[/ {flag=0} flag" CHANGELOG.md)
    [[ -z "$NOTES" ]] && NOTES="Release $NEW_TAG"
    gh release create "$NEW_TAG" --repo "$REPO" --title "$NEW_TAG" --notes "$NOTES"
    echo "✅ GitHub Release $NEW_TAG erstellt."
else
    echo "ℹ️ Release $NEW_TAG existiert bereits auf GitHub."
fi

# 7️⃣ Optional: Debian-Paket bauen und anhängen
read -p "Debian-Paket bauen und an Release anhängen? (y/n) " BUILD_DEB
if [[ "$BUILD_DEB" =~ ^[Yy]$ ]]; then
    if [[ ! -f build_deb.sh ]]; then
        echo "❌ build_deb.sh nicht gefunden!"
        exit 1
    fi
    ./build_deb.sh
    DEB_FILE=$(ls bash-utils*.deb | tail -n1)
    gh release upload "$NEW_TAG" "$DEB_FILE" --repo "$REPO"
    echo "✅ Debian-Paket $DEB_FILE an Release $NEW_TAG hochgeladen."
fi

echo "🚀 Release $NEW_TAG abgeschlossen!"
