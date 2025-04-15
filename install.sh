#!/bin/sh

set -e

install_fzf(){
    echo "installing fzf..."
    if command -v fzf >/dev/null 2>&1; then
        echo "fzf is already installed"
    else
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
        echo "fzf installed."
    fi
}


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

install_fzf
backup_and_replace_bashrc
backup_and_replace_vimrc

echo "✅ Setup complete. Restart your terminal to apply changes."




