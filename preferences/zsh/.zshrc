# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Testcontainers setting
export DOCKER_HOST=unix://${HOME}/.colima/default/docker.sock
export TESTCONTAINERS_RYUK_DISABLED=true
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Powerlevel10k
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"

# Aliases
alias mg="$HOME/mg/bin/mg"
alias mgb="$HOME/mg/bin/mg b"
alias mgg="$HOME/mg/bin/mg g"
alias cat="bat"
alias cal="open 'https://calendar.google.com/calendar/u/0/r'"
alias youtu="open 'https://www.youtube.com'"
alias ls="eza --icons"
alias lt="eza -aT -L2 --color=always --group-directories-first --icons"
alias ltt="eza -aT -L3 --color=always --group-directories-first --icons"
alias vim="nvim"
alias lazygit="LC_ALL=en_US.UTF-8 lazygit"

# IDE-like tmux layout (상단 1개, 하단 3개)
ide() {
    local session_name="${1:-ide}"

    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
    else
        tmux new-session -d -s "$session_name"
        tmux split-window -v -p 30
        tmux split-window -h -p 66
        tmux split-window -h -p 50
        tmux select-pane -t 0
        tmux attach-session -t "$session_name"
    fi
}

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/hunwooha/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Created by `pipx` on 2025-12-31 05:44:50
export PATH="$PATH:/Users/hunwooha/.local/bin"

# Git worktree 이동 함수
# 사용법: gcw {브랜치명} 또는 gcw (fzf로 선택)
gcw() {
  local branch="$1"
  local dir

  if [[ -z "$branch" ]]; then
    # 인자 없으면 fzf로 선택
    dir=$(git worktree list | fzf --height 40% --reverse | awk '{print $1}')
  else
    # 브랜치명으로 검색 (부분 매칭)
    dir=$(git worktree list | grep -i "$branch" | head -1 | awk '{print $1}')
  fi

  if [[ -n "$dir" && -d "$dir" ]]; then
    cd "$dir"
    echo "→ $dir ($(git branch --show-current))"
  else
    echo "worktree not found: $branch"
    git worktree list
  fi
}

# tmux pane title: 명령어 실행 시 명령어, 대기 시 현재 경로 표시
if [[ -n "$TMUX" ]]; then
  preexec() { printf '\033]2;%s\033\\' "$1"; }
  precmd() { printf '\033]2;%s\033\\' "${PWD##*/}"; }
fi

# Load local secrets (API keys, etc.)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
