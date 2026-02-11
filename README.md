# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/), optimized for web development on macOS.

## Quickstart

```bash
git clone https://github.com/tkh44/dotfiles ~/github/dotfiles
cd ~/github/dotfiles
./install.sh
```

## Directory Layout

| Package | Target | Purpose |
|---------|--------|---------|
| `zsh/` | `~/.zshrc.dotfiles`, `~/.zsh/` | Shell config with Spaceship prompt |
| `nvim/` | `~/.config/nvim/` | NVChad-based Neovim config |
| `git/` | `~/.gitconfig` | Git with delta, critique, GPG signing |
| `tmux/` | `~/.tmux.conf` | Tmux with Catppuccin, `Ctrl+a` prefix |
| `ghostty/` | `~/.config/ghostty/` | Ghostty terminal config |
| `bat/` | `~/.config/bat/` | Syntax-highlighted cat replacement |
| `shell/` | `~/bin/`, `~/.p10k.zsh` | Utilities like `worktree-status` |

Each directory is a [stow package](https://www.gnu.org/software/stow/manual/stow.html) that gets symlinked to `$HOME`.

## Key Features

### Shell (zsh)

- Spaceship prompt (minimal, fast)
- 150+ git aliases (`ga`, `gc`, `gp`, `glog`...)
- fnm for Node version management
- `coding()` function creates a 4-pane tmux layout
- fzf/zoxide integration for fuzzy navigation

### Neovim

- NVChad with `doomchad` theme
- LSP: TypeScript, ESLint, Go, HTML/CSS
- Telescope with smart exclusions (node_modules, dist, etc.)
- Keybinds: `jk`→Escape, `;`→`:`, `<leader>gb` for git blame

### Git

- **delta** as pager (syntax-highlighted diffs)
- **critique** as difftool
- GPG commit signing enabled
- `zdiff3` merge style

### Theme

Catppuccin Macchiato everywhere (bat, tmux, ghostty, delta)

## Installation

`install.sh` handles everything:

1. Homebrew + Brewfile packages
2. Oh My Zsh + plugins
3. Stow all packages
4. Prompts for git email/GPG key

## Extensibility

- `~/.zsh/local.zsh` — Machine-specific shell config (gitignored)
- `~/.gitconfig.local` — User email/signing key (gitignored)

See `llms.md` for detailed documentation.
