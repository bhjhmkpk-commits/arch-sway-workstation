#!/usr/bin/env bash
# ==============================================================================
# 🚀 Arch Sway Workstation - 1-Click Reproducible Installer
# Ultra-lightweight (~350 MB RAM, 0% CPU) Everforest Desktop Environment
# ==============================================================================

set -e

# Terminal Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}=================================================================${NC}"
echo -e "${GREEN}  🌿 Arch Sway Workstation Automated Installer                   ${NC}"
echo -e "${GREEN}  Ultra-lightweight (~350MB RAM, 0% CPU) Everforest Dev Desktop  ${NC}"
echo -e "${GREEN}=================================================================${NC}\n"

# 1. Sanity check: Ensure running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo -e "${RED}Error: This script is designed for Arch Linux only.${NC}"
    exit 1
fi

# 2. Check sudo privileges
if ! sudo -v; then
    echo -e "${RED}Error: Sudo privileges required to install packages.${NC}"
    exit 1
fi

# 3. Install packages from packages.txt
echo -e "\n${BLUE}📦 Step 1/6: Installing core packages via pacman...${NC}"
PKG_LIST=$(grep -E -v '^(#|$)' "$SCRIPT_DIR/packages.txt" | tr '\n' ' ')
sudo pacman -S --needed --noconfirm $PKG_LIST

# 4. Create directory structure
echo -e "\n${BLUE}📁 Step 2/6: Setting up directory structure...${NC}"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons/hicolor/512x512/apps"
mkdir -p "$HOME/.local/share/icons/hicolor/256x256/apps"
mkdir -p "$HOME/Pictures/Screenshots"

# 5. Copy configuration files
echo -e "\n${BLUE}⚙️  Step 3/6: Deploying dotfiles and configs...${NC}"
cp -r "$SCRIPT_DIR/dotfiles/config/"* "$HOME/.config/"

# Deploy custom scripts
cp -a "$SCRIPT_DIR/dotfiles/bin/"* "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/"*

# Deploy custom icons & webapps
cp -a "$SCRIPT_DIR/dotfiles/icons/"* "$HOME/.local/share/icons/hicolor/512x512/apps/"
cp -a "$SCRIPT_DIR/dotfiles/icons/"* "$HOME/.local/share/icons/hicolor/256x256/apps/"
cp -a "$SCRIPT_DIR/dotfiles/applications/"* "$HOME/.local/share/applications/"

# Deploy shell profile for tty1 sway auto-start
if [ ! -f "$HOME/.bashrc" ] || ! grep -q "PATH.*\.local/bin" "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

if [ ! -f "$HOME/.bash_profile" ] || ! grep -q "exec sway" "$HOME/.bash_profile"; then
    cat "$SCRIPT_DIR/dotfiles/shell/bash_profile" >> "$HOME/.bash_profile"
fi

# 6. Rebuild desktop & icon caches
echo -e "\n${BLUE}🔄 Step 4/6: Rebuilding icon and application caches...${NC}"
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

# 7. Enable systemd user services
echo -e "\n${BLUE}⚡ Step 5/6: Enabling systemd user services...${NC}"
systemctl --user daemon-reload
systemctl --user enable cliphist.service swayidle.service sway-wellbeing.service 2>/dev/null || true

# 8. Optional: Configure instant TTY1 autologin
echo -e "\n${YELLOW}❓ Step 6/6: TTY1 Autologin Setup${NC}"
read -rp "Would you like to enable automatic login on tty1 for user '$USER'? (y/N): " AUTOLOGIN_CHOICE
if [[ "$AUTOLOGIN_CHOICE" =~ ^[Yy]$ ]]; then
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
    sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf > /dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o "-p -f -- \\u" --noclear --autologin $USER %I \$TERM
EOF
    echo -e "${GREEN}✓ TTY1 autologin configured for $USER!${NC}"
else
    echo -e "Skipping autologin. You can log in manually on tty1 to start Sway."
fi

echo -e "\n${GREEN}=================================================================${NC}"
echo -e "${GREEN}  🎉 Workstation Installation Complete!                         ${NC}"
echo -e "${GREEN}=================================================================${NC}"
echo -e "You can now start Sway by running: ${YELLOW}sway${NC} or simply rebooting."
echo -e "\nQuick Shortcuts:"
echo -e "  • Super + Enter          : Foot Terminal"
echo -e "  • Super + Space / D      : Wofi App Menu"
echo -e "  • Super + Shift + F      : Thunar File Manager"
echo -e "  • Super + B              : Chromium Browser"
echo -e "  • Print / Shift + Print  : Screenshot & Annotation (Satty)"
echo -e "  • Super + Shift + V      : Clipboard History (Cliphist)"
echo -e "  • Super + Escape         : System Monitor (btop)"
echo -e "  • Super + Alt + E        : Wellbeing & Eye Care Menu"
echo -e "  • Super + W              : Close Window"
echo -e "  • Super + Shift + E      : Exit Sway"
echo -e "\n"
