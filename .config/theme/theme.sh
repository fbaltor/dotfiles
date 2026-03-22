#!/bin/bash
# Theme switching for Alacritty, Ghostty, and GNOME desktop.
# Sourced from ~/.bashrc

ALACRITTY_THEME_LINK="$HOME/.config/alacritty/current-theme.toml"
GHOSTTY_CONFIG="$HOME/.config/ghostty/config"

toggle_theme() {
    local current_scheme
    current_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)

    if [[ "$current_scheme" == "'default'" ]]; then
        # Switch to dark
        ln -sf "themes/themes/solarized_dark.toml" "$ALACRITTY_THEME_LINK"
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        sed -i 's/^theme = .*/theme = iTerm2 Solarized Dark/' "$GHOSTTY_CONFIG"
        echo "Switched to dark theme"
    else
        # Switch to light
        ln -sf "themes/themes/solarized_light.toml" "$ALACRITTY_THEME_LINK"
        gsettings set org.gnome.desktop.interface color-scheme 'default'
        sed -i 's/^theme = .*/theme = iTerm2 Solarized Light/' "$GHOSTTY_CONFIG"
        echo "Switched to light theme"
    fi

    # Ghostty has no file watcher — SIGUSR2 is the official reload mechanism
    pkill -SIGUSR2 ghostty 2>/dev/null
}

get_theme() {
    local current_scheme
    current_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)
    if [[ "$current_scheme" == "'default'" ]]; then
        echo "light"
    else
        echo "dark"
    fi
}
