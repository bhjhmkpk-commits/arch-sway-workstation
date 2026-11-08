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
BOLD='\033[1m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}=================================================================${NC}"
echo -e "${GREEN}  🌿 Arch Sway Workstation Automated Installer                   ${NC}"
echo -e "${GREEN}  Ultra-lightweight (~350MB RAM, 0% CPU) Everforest Dev Desktop  ${NC}"
echo -e "${GREEN}=================================================================${NC}\n"

# 1. Sanity check: Ensure running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo -e "${RED}Error: This installer is built specifically for Arch Linux.${NC}"
    exit 1
fi

# 2. Check sudo privileges
if ! sudo -v; then
    echo -e "${RED}Error: Sudo privileges required to install packages and drivers.${NC}"
    exit 1
fi

# Keep sudo timestamp updated during installation
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# 3. Install core packages
echo -e "\n${BLUE}📦 Step 1/7: Installing core system & desktop packages...${NC}"
PKG_LIST=$(grep -E -v '^(#|$)' "$SCRIPT_DIR/packages.txt" | tr '\n' ' ')
sudo pacman -S --needed --noconfirm $PKG_LIST

# 4. GPU Hardware Acceleration Auto-Detection
echo -e "\n${BLUE}🎮 Step 2/7: Detecting GPU hardware drivers...${NC}"
GPU_INFO=$(lspci -k 2>/dev/null | grep -iE 'vga|3d|display' || true)
if echo "$GPU_INFO" | grep -qi "intel"; then
    echo -e "${GREEN}✓ Intel GPU detected. Installing Intel VA-API & Vulkan drivers...${NC}"
    sudo pacman -S --needed --noconfirm intel-media-driver vulkan-intel libva-utils
elif echo "$GPU_INFO" | grep -qiE "amd|radeon"; then
    echo -e "${GREEN}✓ AMD GPU detected. Installing AMD Vulkan & Mesa drivers...${NC}"
    sudo pacman -S --needed --noconfirm vulkan-radeon libva-mesa-driver
else
    echo -e "${YELLOW}Generic / VM graphics detected. Standard Mesa is active.${NC}"
fi

# 5. User permissions & group memberships
echo -e "\n${BLUE}🔑 Step 3/7: Configuring hardware permissions & user groups...${NC}"
# video: brightnessctl without root
# input: keyboard/mouse/touchpad events
sudo usermod -aG video,input "$USER" 2>/dev/null || true
echo -e "${GREEN}✓ Added $USER to 'video' and 'input' groups.${NC}"

# Enable NetworkManager service
sudo systemctl enable --now NetworkManager 2>/dev/null || true

# 6. Backup existing configs if present
BACKUP_DIR="$HOME/.config/arch_sway_backup_$(date +%Y%m%d_%H%M%S)"
HAS_CONFIGS=false
for cfg in sway waybar foot wofi mako satty swaylock mpv; do
    if [ -d "$HOME/.config/$cfg" ]; then
        HAS_CONFIGS=true
        break
    fi
done

if [ "$HAS_CONFIGS" = true ]; then
    echo -e "\n${YELLOW}💾 Existing configurations found. Creating safe backup at:${NC}"
    echo -e "   $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    for cfg in sway waybar foot wofi mako satty swaylock mpv; do
        [ -d "$HOME/.config/$cfg" ] && cp -r "$HOME/.config/$cfg" "$BACKUP_DIR/"
    done
fi

# 7. Create directory structure
echo -e "\n${BLUE}📁 Step 4/7: Setting up directories...${NC}"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons/hicolor/512x512/apps"
mkdir -p "$HOME/.local/share/icons/hicolor/256x256/apps"
mkdir -p "$HOME/Pictures/Screenshots"

# 8. Deploy dotfiles, scripts, and assets
echo -e "\n${BLUE}⚙️  Step 5/7: Deploying Everforest dotfiles, scripts & icons...${NC}"
cp -r "$SCRIPT_DIR/dotfiles/config/"* "$HOME/.config/"

# Deploy custom scripts and set execution rights
cp -a "$SCRIPT_DIR/dotfiles/bin/"* "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/"*

# Deploy 512x512 web application icons & desktop entries
cp -a "$SCRIPT_DIR/dotfiles/icons/"* "$HOME/.local/share/icons/hicolor/512x512/apps/"
cp -a "$SCRIPT_DIR/dotfiles/icons/"* "$HOME/.local/share/icons/hicolor/256x256/apps/"
cp -a "$SCRIPT_DIR/dotfiles/applications/"* "$HOME/.local/share/applications/"

# Deploy shell profile for instant tty1 auto-start
if [ ! -f "$HOME/.bashrc" ] || ! grep -q "PATH.*\.local/bin" "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

if [ ! -f "$HOME/.bash_profile" ] || ! grep -q "exec sway" "$HOME/.bash_profile"; then
    cat "$SCRIPT_DIR/dotfiles/shell/bash_profile" >> "$HOME/.bash_profile"
fi

# Rebuild desktop & icon caches
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

# 9. Enable systemd user services
echo -e "\n${BLUE}⚡ Step 6/7: Activating user systemd services...${NC}"
systemctl --user daemon-reload
systemctl --user enable cliphist.service swayidle.service sway-wellbeing.service 2>/dev/null || true

# 10. Optional AUR Package: Brave Browser
echo -e "\n${YELLOW}🌐 Step 7/7: Optional Applications (Brave Browser)${NC}"
read -rp "Would you like to install Brave Browser (brave-origin-bin via AUR)? (y/N): " INSTALL_BRAVE
if [[ "$INSTALL_BRAVE" =~ ^[Yy]$ ]]; then
    if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
        echo -e "${BLUE}Installing yay-bin AUR helper...${NC}"
        TEMP_AUR=$(mktemp -d)
        git clone https://aur.archlinux.org/yay-bin.git "$TEMP_AUR/yay-bin"
        (cd "$TEMP_AUR/yay-bin" && makepkg -si --noconfirm)
        rm -rf "$TEMP_AUR"
    fi
    if command -v yay &>/dev/null; then
        yay -S --needed --noconfirm brave-origin-bin
    elif command -v paru &>/dev/null; then
        paru -S --needed --noconfirm brave-origin-bin
    fi
    echo -e "${GREEN}✓ Brave Browser installed successfully!${NC}"
else
    echo -e "Skipping Brave. Chromium is pre-installed as the default web engine."
fi

# 11. Optional TTY1 Autologin Setup
echo -e "\n${YELLOW}❓ TTY1 Instant Autologin Setup${NC}"
read -rp "Enable automatic login on tty1 for user '$USER'? (y/N): " AUTOLOGIN_CHOICE
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
echo -e "${GREEN}  🎉 Arch Sway Workstation Installation Complete!               ${NC}"
echo -e "${GREEN}=================================================================${NC}"
echo -e "Start Sway immediately by running: ${BOLD}${YELLOW}sway${NC} or reboot your system."
echo -e "\nEssential Keybindings:"
echo -e "  • Super + Enter          : Foot Terminal"
echo -e "  • Super + Space / D      : Wofi Application Menu"
echo -e "  • Super + Shift + F      : Thunar File Manager"
echo -e "  • Super + B              : Chromium Web Browser"
echo -e "  • Super + Shift + B      : Brave Origin (if installed)"
echo -e "  • Print / Shift + Print  : Screenshot & Annotation (Satty)"
echo -e "  • Super + Shift + V      : Clipboard History (with Clear button)"
echo -e "  • Super + Escape         : System Monitor (btop)"
echo -e "  • Super + Alt + E        : Wellbeing & Eye Care Menu"
echo -e "  • Super + W              : Close Window"
echo -e "  • Super + Shift + E      : Exit Sway"
echo -e "\n"
