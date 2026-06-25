# Dotfiles

My personal Linux configuration files, built around a [Hyprland](https://hyprland.org/) Wayland desktop :p

> Cooked by **AxoltDash** — Salu2!!

---

## You'll see:

| Config | Tool | Description |
| :----- | :--- | :---------- |
| `hypr`     | [Hyprland](https://hyprland.org/) | Wayland compositor — split into modular files for monitors, keybinds, autostart and appearance |
| `waybar`   | [Waybar](https://github.com/Alexays/Waybar) | Status bar with custom scripts and styling |
| `rofi`     | [Rofi](https://github.com/davatorium/rofi) | App launcher with custom theme and scripts |
| `kitty`    | [Kitty](https://sw.kovidgoyal.org/kitty/) | Terminal |
| `nvim`     | [Neovim](https://neovim.io/) | Editor — current config, based on [LazyVim](https://www.lazyvim.org/) |
| `nvim_old` | [Neovim](https://neovim.io/) | Editor — my previous from-scratch config (see note below) |
| `zathura`  | [Zathura](https://pwmt.org/projects/zathura/) | Lightweight PDF / document viewer |

---

**ALL** has a custom theme made with love by me ^^ , this theme was inspired by [xero/miasma](https://github.com/xero/miasma.nvim) and [morhetz/gruvbox](https://github.com/morhetz/gruvbox), but I focused for limit the blue light for the eyes... enjoy it

**TODO: Take screenshots**

## Installation

The `install.sh` script symlinks each config into `~/.config`

```bash
git clone <this-repo> ~/proyects/git/dotfiles
cd ~/proyects/git/dotfiles
./install.sh
```

The script is safe to re-run:

- If a config is already a symlink, it gets replaced
- If a config already exists as a **real** directory, it is skipped (remove it manually to relink)

---

## A note on `nvim_old`

`nvim_old` is my **old Neovim configuration**, written entirely from scratch... I'm currently in the process of **migrating it onto a [LazyVim](https://www.lazyvim.org/) base**, which lives in `nvim`

It's kept here as a reference while the migration is ongoing - the new `nvim` setup is the one in active use hehe...

---

## Notes

- Configs are modular where it makes sense (`hypr` is split into `mod/` and `apparance/` files).
- Requires a Nerd Font installed (JetBrainsMono Nerd Font for the terminal).
- Requires a custom Rainworld Font for the waybar, and this connects with the next point
- **ALSO CHECK MY [NIXOS CONFIGS](https://github.com/AxoltDash/nixos)!!** it has a lot of dependencies (like fonts) and packages for this configs

---

Salu2!!
