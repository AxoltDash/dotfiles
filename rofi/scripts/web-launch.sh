#!/bin/bash

# -- Add new entries here only :
# Format: ["Display name"]="command or URL"
# URLs are opened with xdg-open automatically.
declare -A ENTRIES=(
    # AI
    ["ChatGPT"]="https://chatgpt.com"
    ["DeepSeek"]="https://chat.deepseek.com/"
    ["Gemini"]="https://gemini.google.com/u/1/app"
    ["Claude"]="https://claude.ai/new"
    ["Copilot"]="https://github.com/copilot"
    ["Lumo"]="https://lumo.proton.me/"

    # Communication
    ["WhatsApp"]="https://web.whatsapp.com/"
    ["Gmail"]="https://mail.google.com/mail/u/0/#inbox"
    ["Tuta Email"]="https://app.tuta.com/mail/Oip5uiU-2--9"
    ["Proton Email"]="https://mail.proton.me/u/0/inbox?welcome=true"
    ["Zoom"]="https://cuaieed-unam.zoom.us/j/88430562969"

    # School
    ["Google Classroom"]="https://classroom.google.com/"
    ["FCiencias"]="https://web.fciencias.unam.mx/acceder"
    ["Ingleishon"]="https://ingles.fciencias.unam.mx/cursos/course/view.php?id=2690"
    ["CSES"]="https://cses.fi/problemset/"
	["PuMasMas pu++"]="https://github.com/pumasmas/grupo-2026-2"
    ["Competitive Guide"]="zathura Documents/books/competitive/handbook_cp.pdf"
	["CodeForces"]="https://codeforces.com/group/GzNDQMd4CA/contests"
	["ISC2"]="https://isc2.obrizum.io/org/cc"

    # Dev
    ["GitHub"]="https://github.com/"
    ["NixOS Packages"]="https://search.nixos.org/packages"
    ["Home manager NixOS"]="https://home-manager.dev/manual/24.11/options.xhtml"
    ["Rust"]="https://book.rustlang-es.org/"
    ["Rust - English"]="https://doc.rust-lang.org/book/"
    ["Gitmoji"]="https://gitmoji.dev/"
    ["Translate"]="https://translate.google.com/?sl=en&tl=es&op=translate"

    # Tools
    ["Bitwarden"]="https://vault.bitwarden.com/#/vault"
    ["Notion"]="https://www.notion.so/0b6ccb529f65420fa75ed7f178ba8694"
    ["One Note"]="https://onedrive.live.com/edit.aspx?resid=9FC9AB24401C708E!s02340cb7a941458cae36d9b2d093b1e3&migratedtospo=true&wd=target%28Quick%20Notes.one%7Cfea7eefe-78bf-ca45-9570-3241ad252b7f%2FWELCOME%20TO%20MY%20ONE%20NOTES%7C0669310a-da02-494a-b691-9b69aa9237c4%2F%29&wdorigin=NavigationUrl"

    # Media
    ["YouTube"]="https://www.youtube.com/"
    ["YouTube Music"]="https://music.youtube.com/"
    ["YouTube Music Brave"]="brave https://music.youtube.com/"
    ["Lo-Fi Chill"]="https://www.youtube.com/watch?v=jfKfPfyJRdk"
    ["Pomodoro"]="https://www.youtube.com/watch?v=J2i0cZWCdq4"

    # Apps
    ["Minecraft Bedrock"]="flatpak run io.mrarm.mcpelauncher"
    ["Godot OpenGL3"]="GDK_BACKEND=x11 godot --rendering-driver opengl3"
)

# -- Menu ----------------------------------------------------------------
CHOICE=$(printf '%s\n' "${!ENTRIES[@]}" | sort | rofi -dmenu -i -p "Web:")

[[ -z "$CHOICE" ]] && exit 0

# -- Launch --------------------------------------------------------------
CMD="${ENTRIES[$CHOICE]}"

if [[ "$CMD" == http* ]]; then
    nohup xdg-open "$CMD" >/dev/null 2>&1 &
else
    nohup bash -c "$CMD" >/dev/null 2>&1 &
fi
