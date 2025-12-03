# Skip heavy shell init for AI agents (Cursor, Claude Code)
if [[ -n "$CURSOR_AGENT" || -n "$CLAUDE_CODE" ]]; then
  PS1='%~ %# '
  SKIP_HEAVY_SHELL_INIT=1
fi

# Enable Powerlevel10k instant prompt (only for interactive non-agent shells)
if [[ -z "$SKIP_HEAVY_SHELL_INIT" && -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Lazy load nvm for faster shell startup (~1-2s savings)
export NVM_DIR="$HOME/.nvm"
if [[ -z "$SKIP_HEAVY_SHELL_INIT" ]]; then
  # Track if nvm is loaded
  _nvm_loaded=0

  _load_nvm() {
    if [[ $_nvm_loaded -eq 0 ]]; then
      unset -f node npm npx nvm pnpm yarn 2>/dev/null
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
      _nvm_loaded=1
    fi
  }

  # Lazy load wrappers
  for cmd in node npm npx nvm pnpm yarn; do
    eval "$cmd() { _load_nvm && $cmd \"\$@\" }"
  done

  # Auto-switch node version when entering directory with .nvmrc
  _nvm_auto_use() {
    if [[ -f .nvmrc ]]; then
      _load_nvm
      local nvmrc_node_version=$(cat .nvmrc)
      local current_node_version=$(node -v 2>/dev/null | sed 's/^v//')
      # Only switch if different (check if nvmrc version is prefix of current)
      if [[ ! "$current_node_version" == "$nvmrc_node_version"* ]]; then
        nvm use --silent
      fi
    fi
  }

  # Hook into directory change
  autoload -U add-zsh-hook
  add-zsh-hook chpwd _nvm_auto_use

  # Check on shell start too (for initial directory)
  _nvm_auto_use
fi

if [[ -z "$SKIP_HEAVY_SHELL_INIT" ]]; then
  # zsh-autocomplete must be sourced before compinit
  source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

  ZSH_THEME="powerlevel10k/powerlevel10k"
  plugins=(git)
  source $ZSH/oh-my-zsh.sh
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

  # zsh-autosuggestions (inline ghost text from history)
  [[ -f ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Environment variables
export github="$HOME/github"

# Aliases - Personal
alias nano="code"
alias cat="bat"
alias ls="eza --icons"
alias ff="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias date="gdate"
alias pn="pnpm"
alias vim=nvim
alias vi=nvim
alias bathelp='bat --plain --language=help'

export BAT_THEME="Nord"

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

help() {
    "$@" --help 2>&1 | bathelp
}

export GPG_TTY=$(tty)
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Skip heavy shell integrations in agent mode
if [[ -z "$SKIP_HEAVY_SHELL_INIT" ]]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

export PGHOST=localhost

# Rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Skip heavy completions in agent mode
if [[ -z "$SKIP_HEAVY_SHELL_INIT" ]]; then
  # bun completions
  [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
fi

function cursor {
  open -a "/Applications/Cursor.app" "$@"
}

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# Custom terminal title: "dir|process"
function set_terminal_title() {
  local dir="${PWD##*/}"
  [[ -z "$dir" ]] && dir="~"
  print -Pn "\e]0;${dir}|zsh\a"
}

function set_terminal_title_with_cmd() {
  local dir="${PWD##*/}"
  [[ -z "$dir" ]] && dir="~"
  local cmd="${1[(w)1]}"
  print -Pn "\e]0;${dir}|${cmd}\a"
}

precmd_functions+=(set_terminal_title)
preexec_functions+=(set_terminal_title_with_cmd)

# Cached zoxide init (regenerate with: zoxide init zsh > ~/.cache/zoxide.zsh)
[[ -f ~/.cache/zoxide.zsh ]] && source ~/.cache/zoxide.zsh

# Source local/work-specific config (not in dotfiles repo)
[[ -f ~/.zsh/local.zsh ]] && source ~/.zsh/local.zsh
