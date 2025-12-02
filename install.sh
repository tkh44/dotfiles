#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==================================="
echo "  Dotfiles Installation Script"
echo "==================================="
echo ""

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed"
fi

# Install packages from Brewfile
echo ""
echo "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Install Oh My Zsh if not present
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo ""
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    echo ""
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# Install zsh-autocomplete plugin
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete" ]]; then
    echo ""
    echo "Installing zsh-autocomplete plugin..."
    git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete"
fi

# Backup existing dotfiles and stow
echo ""
echo "Stowing dotfiles..."

# Function to backup and stow
stow_package() {
    local pkg=$1
    echo "  Stowing $pkg..."

    # Use stow with --adopt to handle existing files, then restore from repo
    cd "$DOTFILES_DIR"
    stow -v -t "$HOME" "$pkg" 2>/dev/null || stow -v --adopt -t "$HOME" "$pkg"

    # If we adopted files, restore the repo version
    git checkout -- "$pkg" 2>/dev/null || true
}

stow_package "zsh"
stow_package "nvim"
stow_package "git"
stow_package "shell"
stow_package "ghostty"

# Generate zoxide cache
echo ""
echo "Generating zoxide cache..."
mkdir -p ~/.cache
zoxide init zsh > ~/.cache/zoxide.zsh

# Configure git user
echo ""
echo "==================================="
echo "  Git Configuration"
echo "==================================="
current_email=$(git config --global user.email 2>/dev/null || echo "")
if [[ -z "$current_email" ]]; then
    read -p "Enter your git email: " git_email
    git config --global user.email "$git_email"
    echo "Git email set to: $git_email"
else
    echo "Git email already configured: $current_email"
fi

# GPG key setup hint
echo ""
current_key=$(git config --global user.signingkey 2>/dev/null || echo "")
if [[ -z "$current_key" ]]; then
    echo "GPG signing key not configured."
    echo "To set up GPG signing:"
    echo "  1. Generate a key: gpg --full-generate-key"
    echo "  2. List keys: gpg --list-secret-keys --keyid-format=long"
    echo "  3. Set key: git config --global user.signingkey YOUR_KEY_ID"
fi

# Create local.zsh if it doesn't exist
if [[ ! -f "$HOME/.zsh/local.zsh" ]]; then
    echo ""
    echo "Creating empty ~/.zsh/local.zsh for machine-specific config..."
    mkdir -p "$HOME/.zsh"
    cp "$DOTFILES_DIR/zsh/.zsh/local.zsh.example" "$HOME/.zsh/local.zsh"
    echo "Edit ~/.zsh/local.zsh to add machine-specific aliases and config"
fi

echo ""
echo "==================================="
echo "  Installation Complete!"
echo "==================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Edit ~/.zsh/local.zsh for machine-specific config"
echo "  3. Set up GPG signing if needed (see above)"
echo ""
