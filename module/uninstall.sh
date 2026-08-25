#!/system/bin/sh

MODDIR=${0%/*}
. "$MODDIR/config"

NOMOUNT_BIN=""
if [ -x "/data/adb/modules/nomount/bin/nm" ]; then
	NOMOUNT_BIN="/data/adb/modules/nomount/bin/nm"
elif command -v nm >/dev/null 2>&1; then
	NOMOUNT_BIN="$(command -v nm)"
fi


if [ -n "$NOMOUNT_BIN" ] && [ -f "$MODDIR/.last_vpath" ]; then
	while IFS= read -r vp; do
		[ -n "$vp" ] && "$NOMOUNT_BIN" rule del "$vp"
	done < "$MODDIR/.last_vpath"
	rm -f "$MODDIR/.last_vpath"
fi
rm -f "/data/adb/rvhc/${MODDIR##*/}.apk"
rmdir "/data/adb/rvhc"

rm -f "/data/adb/post-fs-data.d/$PKG_NAME-uninstall.sh"
