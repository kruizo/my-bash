#!/bin/sh

set -e

backup_and_replace_bashrc() {
    echo "Backing up and replacing .bashrc..."
    if [[ -f ~/.bashrc ]]; then
        cp ~/.bashrc ~/.bashrc.backup
        echo "Existing backup ~/.bashrc.backup replaced."
    else
        echo "No existing .bashrc found. Creating new one..."
    fi
    cp .bashrc ~/.bashrc
    echo ".bashrc has been replaced."
}

backup_and_replace_vimrc() {
    if ! command -v vim &> /dev/null; then
        echo "Vim is not installed. Please install Vim first."
        return 1
    fi

    if [[ -f ~/.vimrc ]]; then
        cp ~/.vimrc ~/.vimrc.backup
        echo "Existing backup ~/.vimrc.backup replaced."
    else
        echo "No existing .vimrc found. Creating a new one..."
    fi

    cp .vimrc ~/.vimrc
    echo ".vimrc has been replaced."
}

#!/usr/bin/env bash
set -e

check_and_install_ptyxis() {
    if command -v ptyxis &>/dev/null; then
        echo "✅ Ptyxis is already installed."
        return 0
    fi

    echo "⚠️  Ptyxis is required for terminal profile creation but is not installed."
    read -p "Do you want to install Ptyxis now? [Y/N] " answer

    case "$answer" in
        [Yy]* )
            echo "📦 Installing Ptyxis..."
            if command -v dnf &>/dev/null; then
                sudo dnf install -y ptyxis
            elif command -v apt &>/dev/null; then
                sudo apt install -y ptyxis
            elif command -v pacman &>/dev/null; then
                sudo pacman -S --noconfirm ptyxis
            elif command -v flatpak &>/dev/null; then
                echo "Installing via Flatpak..."
                flatpak install -y flathub org.gnome.Ptyxis
            else
                echo "❌ Package manager not recognized. Please install Ptyxis manually."
                return 1
            fi
            echo "✅ Ptyxis installed successfully."
            ;;
        * )
            echo "❌ Ptyxis installation skipped. Cannot continue without it."
            exit 1
            ;;
    esac
}

set_terminal_opacity() {
    echo "🪶 Creating a new Ptyxis profile with 90% opacity..."

    LIST_PATH="org.gnome.Ptyxis profile-uuids"
    DEFAULT_PATH="org.gnome.Ptyxis default-profile-uuid"

    if ! gsettings get org.gnome.Ptyxis profile-uuids &>/dev/null; then
        echo "❌ Ptyxis has no profiles yet. Please open Ptyxis once and close it."
        return 1
    fi

    DEFAULT_PROFILE=$(gsettings get org.gnome.Ptyxis default-profile-uuid | tr -d "'")
    if [ -z "$DEFAULT_PROFILE" ]; then
        echo "❌ Could not find default profile."
        return 1
    fi

    echo "📄 Default profile: $DEFAULT_PROFILE"

    NEW_PROFILE=$(uuidgen)
    PROFILE_NAME="My Ptyxis Profile $(date +%H%M%S)"
    echo "🆕 Creating new profile: $NEW_PROFILE ($PROFILE_NAME)"

    gsettings set org.gnome.Ptyxis profile-uuids "$(gsettings get org.gnome.Ptyxis profile-uuids | sed "s/]$/, '$NEW_PROFILE']/")"
    gsettings set org.gnome.Ptyxis default-profile-uuid "$NEW_PROFILE"

    PROFILE_SCHEMA="org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$NEW_PROFILE/"

    gsettings set "$PROFILE_SCHEMA" opacity 0.9 || true

    echo "✅ New Ptyxis profile '$PROFILE_NAME' created and set as default (UUID: $NEW_PROFILE)"
    echo "➡️  Restart Ptyxis to apply changes."
}

check_and_install_fzf_fd() {
    local missing=()

    if ! command -v fzf &> /dev/null; then
        missing+=("fzf")
    fi

    if ! command -v fd &> /dev/null; then
        missing+=("fd-find")
    fi

    if [ ${#missing[@]} -eq 0 ]; then
        echo "fzf and fd-find are already installed."
        return
    fi

    echo "The following packages are required for the search function: ${missing[*]}"
    read -p "Do you want to install them now? [Y/N] " answer

    case "$answer" in
        [Yy]* )
            echo "Installing ${missing[*]}..."
            sudo dnf install -y "${missing[@]}"
            echo "Installation complete."
            ;;
        * )
            echo "Skipping installation. Some functions may not work."
            ;;
    esac
}

check_and_install_ptyxis
set_terminal_opacity
check_and_install_fzf_fd

echo "✅ Setup complete. Restart your terminal to apply changes."




