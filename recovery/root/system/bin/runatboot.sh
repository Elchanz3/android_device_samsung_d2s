#!/system/bin/sh

navbar_file=${1:-/sdcard/Fox/.navbar/navbar.xml}
[ -f "$navbar_file" ] || exit 0

# Migrate physical heights saved before the theme switched to 1080-wide coordinates.
grep -Eq 'name="screen_h"[[:space:]]+value="(3040|3136)"' "$navbar_file" || exit 0

navbar_tmp=$(mktemp /tmp/d2s-navbar.XXXXXX) || exit 1
trap 'rm -f "$navbar_tmp"' EXIT

sed -E \
    -e 's/(name="screen_h"[[:space:]]+value=")3040(")/\1%screen_original_h%\2/' \
    -e 's/(name="screen_h"[[:space:]]+value=")3136(")/\1%screen_original_h%+96\2/' \
    "$navbar_file" > "$navbar_tmp" || exit 1

# Preserve the settings file's ownership, permissions and SELinux context.
cat "$navbar_tmp" > "$navbar_file" || exit 1
echo "D2s: Updated legacy OrangeFox navigation height."
