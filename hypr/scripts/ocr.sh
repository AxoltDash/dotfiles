#!/usr/bin/env bash
set -euo pipefail

LANG="eng"                     #change "spa" if you want spanish nyehe
ICON="$HOME/.local/share/icons/ocr.svg"
TMPIMG="$(mktemp --suffix=.png)"
trap 'rm -f "$TMPIMG"' EXIT

# Requeridos
for cmd in grim slurp wl-copy tesseract; do
  if ! command -v "$cmd" >/dev/null; then
    echo "Falta $cmd. Instálalo e inténtalo de nuevo." >&2
    exit 1
  fi
done

geometry="$(slurp)"
if [[ -z "$geometry" ]]; then
  exit 0
fi

grim -g "$geometry" "$TMPIMG"

wl-copy --type image/png < "$TMPIMG" || true

ocr_text="$(tesseract "$TMPIMG" stdout -l "$LANG" --oem 1 --psm 3 2>/dev/null || true)"

if [[ -n "${ocr_text//[[:space:]]/}" ]]; then
  echo -n "$ocr_text" | wl-copy
  if command -v notify-send >/dev/null; then
    notify-send -u low -a "FixiOCR" "OCR Ready" "Text -> Clipboard" -i "$ICON" -t 2000
  fi
else
  # Si no hay texto, dejamos la imagen en el clipboard (ya copiada arriba)
  if command -v notify-send >/dev/null; then
	  notify-send -u normal -a "FixiOCR" "OCR Null" "No text (Image in Clipboard)" -i "$TMPIMG" -t 2000
  fi
fi

exit 0
