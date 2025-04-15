# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

export PATH="$HOME/.npm-global/bin:$PATH"


# CUSTOM PROMPT
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
git_dirty() {
    git diff --quiet 2> /dev/null || echo "*"
}
__git_ps1() {
    local branch=$(git_branch)
    local dirty=$(git_dirty)
    if [ -n "$branch" ]; then
        echo " ✘ $branch$dirty"
    fi
}
fcd() {
  local EXCLUDES=(--exclude .node_modules --exclude .git --exclude .cache --exclude .local)
 
  local old=(--exclude .git --exclude Downloads --exclude .npm-global --exclude .var --exclude .vscode --exclude .local --exclude .npm --exclude .mozilla --exclude .cache --exclude .icons --exclude .themes)
  local GENERAL_DIRS
  local PERSONAL_DIRS
  local dir

  # General directories (max depth = 1)
  GENERAL_DIRS=$(fd --type d --hidden --max-depth 1 "${EXCLUDES[@]}" . "$HOME")

  # Deeper directories for ~/personal (max depth = 4)
  PERSONAL_DIRS=$(fd --type d --hidden --max-depth 3 "${EXCLUDES[@]}" . "$HOME/personal")

  # Merge results, pass to fzf
  dir=$(printf "%s\n%s" "$GENERAL_DIRS" "$PERSONAL_DIRS" | fzf --select-1 --exit-0)

  [[ -n "$dir" ]] && cd "$dir"
  }

bind '"\C-@": "fcd\n"'
bind '"\C-e": "vim\n"'
export PS1='\[\e[1;33m\]↪ \[\e[1;37m\] \W\[\e[31m\]$(__git_ps1)\[\e[0m\] '

# TERMINAL
alias ls='ls --color=auto'
alias la='ls -a'
alias lla='ls -la'
alias ll='ls -lrt'
alias cls='clear'
alias cp='cd personal/'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias cpv='rsync -avh --info=progress2'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# DOCKER
alias di='docker images'
alias diclean='docker image prune -f' 
alias dc='docker ps -a'
alias dclean='docker container prune -f'
alias dcs='docker-compose'
alias dce='docker-compose exec'
alias dcr='docker-compose run'
alias dcb='docker compose build'
alias dup='docker-compose up -d'
alias dcd='docker-compose down'

# GIT
alias gcm='git commit -m'
alias gaa='git add .'
alias gcc='git checkout'
alias gcb='git checkout -b'
alias gbr='git branch -a'
alias gaddr='git remote add origin'
alias gpull='git pull'
alias gpush='git push'
alias glog='git log --oneline'
alias gstash='git stash'
alias gpop='git stash pop'
alias glist='git stash list'
alias gdrop='git stash drop'
alias gclone='git clone'

export PATH="$HOME/.config/composer/vendor/bin:$PATH"
