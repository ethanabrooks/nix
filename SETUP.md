# macOS Setup with Nix + Home Manager

Declaratively installs CLI tools and shell settings from a single file (`home.nix`). Edit it, run `update`, done. Clone on another machine for the same setup.

## Fresh machine setup

```bash
# 1. Install Xcode CLI tools
xcode-select --install

# 2. Install Nix (restart terminal after)
curl -L https://nixos.org/nix/install | sh

# 3. Enable flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# 4. Clone config
git clone https://github.com/ethanabrooks/nix.git ~/.config/home-manager

# 5. Bootstrap home-manager
nix run home-manager -- switch --flake ~/.config/home-manager

# 6. Open a new terminal. Done.
```

To clone via SSH instead, set up a key first (see below) and use:
`git clone git@github.com:ethanabrooks/nix.git ~/.config/home-manager`

## Day-to-day

```bash
nvim ~/.config/home-manager/home.nix   # edit config
update                                  # apply changes
cd ~/.config/home-manager && nix flake update && update  # update packages
```

## Files

| File | Purpose |
|------|---------|
| `flake.nix` | Pins nixpkgs and home-manager versions |
| `flake.lock` | Lockfile (commit this) |
| `home.nix` | All packages, programs, and shell config |
| `home-manager/tmux.conf` | Tmux settings |
| `home-manager/zshrc` | Extra zsh config |

## SSH key setup

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
# Add at https://github.com/settings/keys
```
