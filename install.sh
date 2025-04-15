#!/bin/sh

set -e

backup_and_replace_bashrc() {
    echo "Backing up and replacing .bashrc..."
    cp ~/.bashrc ~/.bashrc.backup.$(date +%s)
    cp .bashrc ~/.bashrc
    echo ".bashrc has been replaced."
}

backup_and_replace_vimrc() {
    echo "Backing up and replacing .vimrc..."
    cp ~/.vimrc ~/.vimrc.backup.$(date +%s)
    cp .vimrc ~/.vimrc
    echo ".vimrc has been replaced."
}

set_terminal_opacity() {
    echo "Setting terminal opacity to 0.90..."
    PROFILE=$(dconf list /org/gnome/terminal/legacy/profiles:/ | head -n 1 | tr -d '/')
    if [ -z "$PROFILE" ]; then
        echo "No terminal profile found. Skipping opacity setting."
    else
        dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE/background-transparency-percent 10
        echo "Terminal opacity set to 0.90."
    fi
}

backup_and_replace_bashrc
backup_and_replace_vimrc
set_terminal_opacity

echo "✅ Setup complete. Restart your terminal to apply changes."




