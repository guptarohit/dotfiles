# Tmux Workflow

This document describes the tmux session management workflow using sesh, tmux-resurrect, and tmux-continuum.

## Tools

| Tool | Purpose |
|------|---------|
| [sesh](https://github.com/joshmedeski/sesh) | Fuzzy-find and switch between tmux sessions |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Save and restore tmux sessions |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Auto-save sessions every 15 minutes |

## Quick Reference

| Action | Command |
|--------|---------|
| List all sessions | `sesh list` |
| Connect to/create session | `sesh connect` (opens fzf picker) |
| Save sessions manually | `prefix + Ctrl-s` |
| Restore sessions | `prefix + Ctrl-r` |
| View resurrect status | `prefix + Ctrl-*` |

## Workflow

### Starting a session

```sh
# Option 1: sesh (recommended)
sesh connect
# → fzf shows running sessions + git repos
# → Pick one, or type to create new session

# Option 2: traditional
tmux new -s myproject
```

### Switching between sessions

```sh
# From inside or outside tmux:
sesh connect
# → Shows all running sessions and git repos
# → Fuzzy search to filter, Enter to select
```

### What survives what

| Event | Sessions preserved? | How? |
|-------|--------------------| ---|
| Close terminal | Yes | tmux runs as background daemon |
| `tmux kill-session` | No | Session explicitly terminated |
| Reboot | No (without continuum) | N/A |
| Reboot | Yes (with continuum) | Auto-restores on `tmux` start |
| Crash | Yes (with continuum) | Auto-restores on `tmux` start |

### Session recovery

After a reboot or crash:

```sh
tmux
# → tmux-continuum automatically restores your last session
# → All windows, panes, and running commands are recovered
```

Manual restore (if auto-restore is disabled):

```sh
# Inside tmux:
prefix + Ctrl-r
```

### Saving sessions

**Manual:** `prefix + Ctrl-s`

**Automatic:** tmux-continuum auto-saves every 15 minutes. No action needed.

Saves include:
- Session names and window/pane layout
- Running commands (pane contents)
- Current working directories

## Keybindings

### Tmux (built-in)

| Key | Action |
|-----|--------|
| `prefix + c` | New window |
| `prefix + &` | Kill window |
| `prefix + ,` | Rename window |
| `prefix + %` | Split pane horizontally |
| `prefix + "` | Split pane vertically |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + z` | Zoom pane (full screen) |

### Resurrect

| Key | Action |
|-----|--------|
| `prefix + Ctrl-s` | Save session |
| `prefix + Ctrl-r` | Restore session |

### Continuum

| Key | Action |
|-----|--------|
| `prefix + I` | Install/update TPM plugins |

## First-time setup

```sh
# Install plugins (run once after initial setup)
prefix + I

# This installs: catppuccin, resurrect, continuum
```

## Customization

Edit `~/.tmux.conf` to adjust:

```sh
# Auto-restore on tmux start (on/off)
set -g @continuum-restore 'on'

# Save pane contents (slower but more complete)
set -g @resurrect-capture-pane-contents 'on'

# Auto-save interval (default: 15 minutes)
set -g @continuum-save-interval '15'
```
