# Tmux Quick Guide

Your prefix key is **Ctrl+a** (press and release, then the command key).

## Getting Started

```bash
tmux                    # Start new session
tmux new -s work        # Start named session
tmux ls                 # List sessions
tmux a                  # Attach to last session
tmux a -t work          # Attach to named session
tmux kill-session -t x  # Kill session
```

## Essential Keybindings

All commands below require prefix (`Ctrl+a`) first, unless marked with `*`.

### Sessions
| Key | Action |
|-----|--------|
| `d` | Detach from session |
| `$` | Rename session |
| `s` | List/switch sessions |
| `Ctrl+s` | Save session (resurrect) |
| `Ctrl+r` | Restore session (resurrect) |

### Windows (tabs)
| Key | Action |
|-----|--------|
| `c` | Create new window |
| `n` | Next window |
| `p` | Previous window |
| `0-9` | Go to window # |
| `,` | Rename window |
| `&` | Close window |
| `*Ctrl+h` | Previous window (no prefix) |
| `*Ctrl+l` | Next window (no prefix) |

### Panes (splits)
| Key | Action |
|-----|--------|
| `|` | Split vertical |
| `-` | Split horizontal |
| `h/j/k/l` | Navigate panes (vim-style) |
| `H/J/K/L` | Resize panes |
| `x` | Close pane |
| `z` | Toggle pane zoom |
| `Space` | Cycle layouts |
| `{` / `}` | Swap pane position |

### Copy Mode
| Key | Action |
|-----|--------|
| `[` | Enter copy mode |
| `v` | Start selection (in copy mode) |
| `y` | Copy selection (in copy mode) |
| `]` | Paste |
| `Escape` | Exit copy mode |

## Plugins

| Key | Action |
|-----|--------|
| `I` | Install plugins |
| `U` | Update plugins |
| `Alt+u` | Uninstall removed plugins |

## Tips

- **Mouse support is enabled** - click to select panes, scroll to navigate
- **Sessions auto-save** every 10 minutes via continuum
- **Reload config** with `prefix + r`
- **New panes/windows** open in the current directory

## Installed Plugins

- **tmux-sensible** - Better defaults
- **tmux-resurrect** - Save/restore sessions
- **tmux-continuum** - Auto-save sessions
- **tmux-yank** - Better copy/paste
- **catppuccin/tmux** - Macchiato theme
