# Theme Switching

Synchronized light/dark theme switching across terminal emulators and the GNOME desktop.

## Usage

```bash
toggle_theme   # switch between light and dark
get_theme      # print current theme ("light" or "dark")
```

## How it works

The source of truth is GNOME's `org.gnome.desktop.interface color-scheme` gsetting.
`toggle_theme` reads it, flips it, and updates each emulator:

| Emulator  | Theme mechanism                          | Reload trigger                   |
|-----------|------------------------------------------|----------------------------------|
| Alacritty | Symlink `current-theme.toml` → theme file | Alacritty watches the symlink    |
| Ghostty   | `theme = ...` line rewritten via `sed`   | `SIGUSR2` signal to reload config |
| GNOME/GTK | `gsettings set color-scheme`             | Immediate (D-Bus)                |

## Files

```
~/.config/theme/
├── README.md              # this file
└── theme.sh               # toggle_theme + get_theme (sourced by ~/.bashrc)

~/.config/alacritty/
├── alacritty.toml          # imports current-theme.toml
├── current-theme.toml      # symlink → themes/themes/solarized_{light,dark}.toml
└── themes/                 # third-party theme definitions (git submodule)

~/.config/ghostty/
└── config                  # contains `theme = iTerm2 Solarized {Light,Dark}`
```

## Adding a new terminal emulator

1. Add its theme-update logic (sed, symlink, etc.) to both branches of `toggle_theme` in `theme.sh`.
2. Add a reload trigger if the emulator doesn't auto-detect file changes.
3. Update this README.
