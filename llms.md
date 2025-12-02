# Dotfiles Repository

> Personal dotfiles managed with GNU Stow for Kye Hohenberger (@tkh44)

## What This Is

A portable, version-controlled collection of shell and editor configurations. Uses GNU Stow for symlink management - each top-level directory is a "package" that gets symlinked to $HOME.

## Repository Structure

```
dotfiles/
├── install.sh          # One-command bootstrap script
├── Brewfile            # Homebrew packages to install
├── llms.txt            # This file - AI context
├── zsh/                # Stow package → ~/.zshrc, ~/.zsh/
├── nvim/               # Stow package → ~/.config/nvim/
├── git/                # Stow package → ~/.gitconfig, ~/.gitignore_global
├── shell/              # Stow package → ~/.p10k.zsh
└── ghostty/            # Stow package → ~/.config/ghostty/
```

## How Stow Works

Each directory is a "package". Running `stow zsh` creates symlinks:
- `dotfiles/zsh/.zshrc` → `~/.zshrc`
- `dotfiles/zsh/.zsh/` → `~/.zsh/`

The directory structure inside each package mirrors $HOME.

## Key Files

| File | Purpose |
|------|---------|
| `zsh/.zshrc` | Main shell config (oh-my-zsh, aliases, functions) |
| `zsh/.zsh/local.zsh.example` | Template for machine-specific config |
| `nvim/.config/nvim/` | NVChad-based Neovim setup |
| `git/.gitconfig` | Git aliases and preferences (no email/keys) |
| `shell/.p10k.zsh` | Powerlevel10k prompt theme |
| `ghostty/.config/ghostty/config` | Ghostty terminal config (JetBrainsMono Nerd Font) |
| `Brewfile` | CLI tools, fonts (JetBrainsMono Nerd Font), Ghostty |

## How to Modify

### Adding a new dotfile to an existing package
```bash
# Example: add .tmux.conf to shell package
mkdir -p dotfiles/shell
cp ~/.tmux.conf dotfiles/shell/.tmux.conf
cd dotfiles && stow shell
```

### Creating a new package
```bash
# Example: add tmux as new package
mkdir -p dotfiles/tmux
cp ~/.tmux.conf dotfiles/tmux/.tmux.conf
cd dotfiles && stow tmux
# Update install.sh to include: stow_package "tmux"
```

### Adding a config in ~/.config/
```bash
# Example: add kitty terminal config
mkdir -p dotfiles/kitty/.config/kitty
cp ~/.config/kitty/kitty.conf dotfiles/kitty/.config/kitty/
cd dotfiles && stow kitty
```

### Adding Homebrew packages
Edit `Brewfile` and add:
```
brew "package-name"
# or for GUI apps:
cask "app-name"
```

### Machine-specific config
Edit `~/.zsh/local.zsh` (this file is NOT in the repo):
- Work aliases and paths
- Machine-specific environment variables
- API keys (use secrets manager when possible)

## What NOT to Commit

NEVER add these to the repo:
- `.netrc` - credentials
- `.npmrc` - registry tokens
- `.aws/` - AWS credentials
- `.env*` - environment secrets
- `*.cer`, `*.pem`, `*.key` - certificates/keys
- `.zsh/local.zsh` - machine-specific config
- Work-specific profiles

## Common Tasks

### Fresh machine setup
```bash
git clone https://github.com/tkh44/dotfiles ~/github/dotfiles
cd ~/github/dotfiles
./install.sh
```

### Update after editing dotfiles
```bash
cd ~/github/dotfiles
git add -A && git commit -m "Update config" && git push
```

### Pull changes on another machine
```bash
cd ~/github/dotfiles
git pull
# Stow will update symlinks automatically since files are linked
```

### Remove a package
```bash
cd ~/github/dotfiles
stow -D package-name  # Removes symlinks
```

## Tech Stack

- **Shell**: Zsh + Oh My Zsh + Powerlevel10k
- **Editor**: Neovim with NVChad
- **Tools**: bat, eza, fzf, zoxide, ripgrep
- **Management**: GNU Stow

## Links

- Repository: https://github.com/tkh44/dotfiles
- GNU Stow: https://www.gnu.org/software/stow/
- Oh My Zsh: https://ohmyz.sh/
- NVChad: https://nvchad.com/
- Powerlevel10k: https://github.com/romkatv/powerlevel10k
