# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quickstart

```bash
git clone https://github.com/tkh44/dotfiles ~/github/dotfiles
cd ~/github/dotfiles
./install.sh
```

## What's Included

- **zsh** - Shell config with oh-my-zsh, Powerlevel10k, lazy-loaded nvm
- **nvim** - Neovim with NVChad
- **git** - Git aliases and settings
- **ghostty** - Terminal config (JetBrainsMono Nerd Font)
- **Brewfile** - CLI tools (bat, eza, fzf, zoxide, ripgrep, etc.)

## Structure

Each directory is a [stow package](https://www.gnu.org/software/stow/manual/stow.html) that gets symlinked to `$HOME`.

```
zsh/      → ~/.zshrc, ~/.zsh/
nvim/     → ~/.config/nvim/
git/      → ~/.gitconfig, ~/.gitignore_global
shell/    → ~/.p10k.zsh
ghostty/  → ~/.config/ghostty/
```

## Machine-Specific Config

Add local aliases and work config to `~/.zsh/local.zsh` (not tracked).

See `llms.md` for detailed documentation.
