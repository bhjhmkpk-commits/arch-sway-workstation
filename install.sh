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
# i2c: ddcutil hardware monitor brightness without root
sudo usermod -aG video,input,i2c "$USER" 2>/dev/null || true
echo -e "${GREEN}✓ Added $USER to 'video', 'input', and 'i2c' groups.${NC}"

# Enable DDC/CI monitor kernel module and system maintenance timers
echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c-dev.conf >/dev/null || true
sudo modprobe i2c-dev 2>/dev/null || true
sudo systemctl enable --now fstrim.timer paccache.timer 2>/dev/null || true

# Enable NetworkManager and disable redundant networkd
sudo systemctl enable --now NetworkManager 2>/dev/null || true
sudo systemctl disable --now systemd-networkd.socket systemd-networkd.service 2>/dev/null || true

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
sudo ln -sf "$HOME/.local/bin/sys-optimize" "/usr/local/bin/sys-optimize"
sudo ln -sf "$HOME/.local/bin/brave-origin" "/usr/local/bin/brave-origin"
sudo ln -sf "$HOME/.local/bin/yt-dlp-menu" "/usr/local/bin/yt-dlp-menu"

# Deploy Polkit rules for passwordless Ventoy
if [ -f "$SCRIPT_DIR/dotfiles/config/polkit-1/50-ventoy.rules" ]; then
    sudo mkdir -p /etc/polkit-1/rules.d
    sudo cp -f "$SCRIPT_DIR/dotfiles/config/polkit-1/50-ventoy.rules" "/etc/polkit-1/rules.d/50-ventoy.rules"
    sudo chmod 644 "/etc/polkit-1/rules.d/50-ventoy.rules"
fi

# Deploy 512x512 web application icons & desktop entries
cp -a "$SCRIPT_DIR/dotfiles/icons/"* "$HOME/.local/share/icons/hicolor/512x512/apps/"
cp -a "$SCRIPT_DIR/dotfiles/icons/"* "$HOME/.local/share/icons/hicolor/256x256/apps/"
cp -a "$SCRIPT_DIR/dotfiles/applications/"* "$HOME/.local/share/applications/"

# Deploy shell profile and modern productivity environment
cp -a "$SCRIPT_DIR/dotfiles/shell/bashrc" "$HOME/.bashrc"
cp -a "$SCRIPT_DIR/dotfiles/shell/bash_profile" "$HOME/.bash_profile"

# Rebuild desktop & icon caches
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

# 9. Enable systemd user services
echo -e "\n${BLUE}⚡ Step 6/7: Activating user systemd services...${NC}"
systemctl --user daemon-reload
systemctl --user enable cliphist.service swayidle.service sway-wellbeing.service 2>/dev/null || true

# 10. Install AUR Packages (Ventoy, UAD, LocalSend, Brave)
echo -e "\n${YELLOW}📦 Step 7/8: Installing AUR Packages...${NC}"
if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
    echo -e "${BLUE}Installing yay-bin AUR helper...${NC}"
    TEMP_AUR=$(mktemp -d)
    git clone https://aur.archlinux.org/yay-bin.git "$TEMP_AUR/yay-bin"
    (cd "$TEMP_AUR/yay-bin" && makepkg -si --noconfirm)
    rm -rf "$TEMP_AUR"
fi
AUR_CMD="yay"
command -v paru &>/dev/null && AUR_CMD="paru"

if [ -f "$SCRIPT_DIR/packages-aur.txt" ]; then
    AUR_PKGS=$(grep -E -v '^(#|$)' "$SCRIPT_DIR/packages-aur.txt" | tr '\n' ' ')
    $AUR_CMD -S --needed --noconfirm $AUR_PKGS || true
fi

read -rp "Would you like to install Brave Browser via AUR? (y/N): " INSTALL_BRAVE
if [[ "$INSTALL_BRAVE" =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Attempting to install brave-origin-bin (minimalist edition)...${NC}"
    if ! $AUR_CMD -S --needed --noconfirm brave-origin-bin; then
        echo -e "${YELLOW}Notice: brave-origin-bin upstream download failed. Falling back to brave-bin...${NC}"
        $AUR_CMD -S --needed --noconfirm brave-bin
    fi
    echo -e "${GREEN}✓ Brave Browser installed successfully!${NC}"
else
    echo -e "Skipping Brave. Chromium is pre-installed as the default web engine."
fi

# 11. Minimal TUI Login Manager (greetd + tuigreet)
echo -e "\n${BLUE}🔒 Step 8/8: Configuring minimal tuigreet login manager...${NC}"
sudo mkdir -p /etc/greetd
sudo tee /etc/greetd/config.toml > /dev/null <<EOF
[terminal]
vt = 1

[default_session]
command = "tuigreet --time --remember --remember-user-session --asterisks --greeting 'Arch Sway Workstation' --cmd sway"
user = "greeter"
EOF
sudo systemctl enable greetd.service
echo -e "${GREEN}✓ Minimal tuigreet login manager configured and enabled!${NC}"

# 12. Host Security: Firewall (UFW)
echo -e "\n${BLUE}🛡️ Configuring host firewall (UFW)...${NC}"
sudo ufw default deny incoming >/dev/null 2>&1 || true
sudo ufw default allow outgoing >/dev/null 2>&1 || true
sudo ufw allow 53317/tcp comment 'LocalSend file transfer' >/dev/null 2>&1 || true
sudo ufw allow 53317/udp comment 'LocalSend discovery' >/dev/null 2>&1 || true
sudo ufw allow 8088/tcp comment 'Phone Clipboard Bridge' >/dev/null 2>&1 || true
sudo ufw --force enable >/dev/null 2>&1 || true
sudo systemctl enable ufw.service >/dev/null 2>&1 || true
echo -e "${GREEN}✓ Host firewall active with LocalSend & Phone Clip ports open!${NC}"

# 13. System Optimizations & Boot Speedups
echo -e "\n${BLUE}⚡ Running workstation system & boot optimizations...${NC}"
# Optimize Thunar remote file handling & thumbnailing (cap remote thumbnail choke to 20MB)
if command -v xfconf-query >/dev/null 2>&1; then
    xfconf-query -c thunar -p /misc-thumbnail-max-file-size -n -t int -s 20971520 2>/dev/null || xfconf-query -c thunar -p /misc-thumbnail-max-file-size -s 20971520 2>/dev/null || true
fi
sudo "$HOME/.local/bin/sys-optimize" || true

echo -e "\n${GREEN}=================================================================${NC}
${GREEN}  🎉 Arch Sway Workstation Installation Complete!               ${NC}
${GREEN}=================================================================${NC}
Start Sway immediately by running: ${BOLD}${YELLOW}sway${NC} or reboot your system.
\nEssential Keybindings:
  • Super + k              : Interactive Utility Chart & Guide
  • Super + /              : Searchable Keybinding Finder
  • Super + c / v          : Universal Copy / Paste across all apps
  • Super + Ctrl + m       : Phone Storage in Thunar (Samsung style)
  • Super + Ctrl + p       : Phone <> PC Clipboard Bridge (QR code)
  • Super + Enter          : Foot Terminal
  • Super + Space / D      : Wofi Application Menu
  • Super + Shift + F      : Thunar File Manager
  • Super + B              : Chromium Web Browser
  • Print / Shift + Print  : Screenshot & Annotation (Satty)
  • Super + Shift + O      : Instant Screen OCR to Clipboard
  • Super + Shift + V      : Clipboard History Menu
  • Super + Escape         : System Monitor (btop)
  • Super + Alt + E        : Wellbeing & Eye Care Menu
  • Super + W              : Close Window
  • Super + Shift + E      : Power Menu (Power Off / Reboot / Logout)
\n"
