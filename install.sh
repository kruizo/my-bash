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

backup_and_replace_bashrc
backup_and_replace_vimrc
set_terminal_opacity
check_and_install_fzf_fd

echo "✅ Setup complete. Restart your terminal to apply changes."




