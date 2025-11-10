# Nix Configuration

Minimal, idiomatic Nix flake configuration for macOS using home-manager.

## Structure

```
.
├── flake.nix              # Flake definition
├── home.nix               # Home Manager configuration
└── home-manager/
    ├── tmux.conf          # Tmux config
    └── zshrc              # Zsh extras
```

## Initial Setup (First Time)

### Automated Setup (Recommended)

After installing Nix, simply run:

```bash
cd ~/nix  # or wherever you cloned this repo
./setup.sh
```

This script will:
- Create the `~/.config/home-manager` symlink
- Enable flakes in nix.conf
- Update flake inputs to latest versions
- Install and activate home-manager
- Generate an SSH key if needed
- Set up GitHub authentication
- Upload your SSH key to GitHub
- Convert Git remotes from HTTPS to SSH

### Manual Setup

1. **Restart your terminal** so `nix` command is available

2. **Update flake inputs** (gets latest nixpkgs-unstable):
   ```bash
   cd ~/.config/home-manager
   nix flake update
   ```

3. **Install and activate home-manager**:
   ```bash
   nix run home-manager/master -- switch --flake ~/.config/home-manager#ethan
   ```

4. **After first activation**, use the simpler command or alias:
   ```bash
   home-manager switch --flake ~/.config/home-manager#ethan
   # Or just use the alias:
   update
   ```

## Ongoing Usage

- **Update packages**: `nix flake update` (in ~/.config/home-manager)
- **Apply changes**: `update` or `home-manager switch --flake ~/.config/home-manager#ethan`

## What's Included

### CLI Tools
- `gh` - GitHub CLI
- `htop` - Process viewer
- `ncdu` - Disk usage analyzer
- `ripgrep` - Fast grep
- `speedtest-cli` - Network speed test
- `tree` - Directory tree view
- `coreutils` - GNU core utilities

### Nix Tooling
- `alejandra` - Opinionated Nix formatter
- `nixpkgs-fmt` - Conservative Nix formatter

### Shell & Tools
- **zsh** with Pure prompt, vi keybindings, autosuggestions
- **tmux** with Ctrl-S prefix, vi mode
- **neovim** as default editor
- **direnv** with Nix support
- **fzf** fuzzy finder
- **dircolors** for colored ls

### Git Config
- User: ethanabrooks / ethanabrooks@gmail.com
- Editor: nvim
- Aliases: br, cm, co, df, lg

## Formatting Nix Code

```bash
# Opinionated (alejandra)
alejandra .

# Conservative (nixpkgs-fmt)
nixpkgs-fmt flake.nix home.nix
```

## Customization

- Edit [home.nix](home.nix) for packages and programs
- Edit [home-manager/tmux.conf](home-manager/tmux.conf) for tmux settings
- Edit [home-manager/zshrc](home-manager/zshrc) for extra zsh config
