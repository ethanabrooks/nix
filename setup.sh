#!/usr/bin/env bash
set -e

echo "🚀 Setting up Nix Home Manager environment..."

# 1. Ensure we're in the right directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 2. Create symlink to ~/.config/home-manager if it doesn't exist
if [ ! -L "$HOME/.config/home-manager" ]; then
    echo "📁 Creating symlink: ~/.config/home-manager -> $SCRIPT_DIR"
    mkdir -p "$HOME/.config"
    ln -sf "$SCRIPT_DIR" "$HOME/.config/home-manager"
fi

# 3. Ensure nix.conf has flakes enabled
echo "⚙️  Configuring Nix with flakes support..."
mkdir -p "$HOME/.config/nix"
echo "experimental-features = nix-command flakes" > "$HOME/.config/nix/nix.conf"

# 4. Update flake inputs
echo "📦 Updating flake inputs to latest versions..."
nix flake update

# 5. Install and activate home-manager
echo "🏗️  Building and activating home-manager configuration..."
nix run home-manager/master -- switch --flake "$HOME/.config/home-manager#ethan"

# 6. Generate SSH key if it doesn't exist
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "🔑 Generating SSH key..."
    ssh-keygen -t ed25519 -C "ethanabrooks@gmail.com" -f "$HOME/.ssh/id_ed25519" -N ""
    ssh-add "$HOME/.ssh/id_ed25519"
    echo "✅ SSH key generated at ~/.ssh/id_ed25519"
else
    echo "✅ SSH key already exists at ~/.ssh/id_ed25519"
fi

# 7. GitHub authentication and SSH key upload
echo ""
echo "🔐 GitHub Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if ! gh auth status &>/dev/null; then
    echo "Please authenticate with GitHub (choose SSH protocol):"
    gh auth login
fi

# Refresh auth with SSH key scope if needed
echo "📤 Uploading SSH key to GitHub..."
gh auth refresh -h github.com -s admin:public_key 2>/dev/null || true
gh ssh-key add "$HOME/.ssh/id_ed25519.pub" --title "$(hostname)" 2>/dev/null || echo "SSH key may already be uploaded"

# 8. Convert any HTTPS remotes to SSH
echo ""
echo "🔧 Converting Git remotes from HTTPS to SSH..."
for remote in $(git remote); do
    url=$(git remote get-url "$remote")
    if [[ $url == https://github.com/* ]]; then
        ssh_url=$(echo "$url" | sed 's|https://github.com/|git@github.com:|')
        git remote set-url "$remote" "$ssh_url"
        echo "  ✓ $remote: $url -> $ssh_url"
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✨ Setup complete!"
echo ""
echo "Next steps:"
echo "  • Restart your terminal to load the new environment"
echo "  • Run 'update' to apply future configuration changes"
echo "  • Your SSH key is ready for GitHub"
