# 🌿 Arch Sway Workstation

An ultra-lightweight, blazing-fast (~350 MB idle RAM, 0.0% CPU) **Everforest-themed** Sway desktop workstation built for distraction-free development and long-term eye health.

![Waybar Preview](dotfiles/waybar_preview.png)

---

## ⚡ What Makes This Setup Different?

- **Extreme Low Footprint**: Consumes only **~350 MB RAM** on idle, leaving **95%+ of your hardware** for browsers, Docker, compilation, and LLM dev.
- **Zero Background Daemons**: No Electron wrappers, no heavy display managers (GDM/SDDM), and no phantom background processes.
- **Eye Care & Screen Wellness**: Built-in 20-20-20 eye rest timer, screen-on time (SOT) tracking, and blue-light temperature control (`wlsunset`).
- **Everforest Palette**: Cohesive organic forest-green aesthetic across Sway, Waybar, Foot terminal, Wofi, Mako, and Satty.
- **100% Native Wayland**: Built exclusively on native C/Rust Wayland tools (`sway`, `foot`, `wofi`, `waybar`, `mako`, `satty`, `grim`, `slurp`).

---

## 💿 Step 1: Base Operating System (What ISO to Boot)

This workstation runs on **pure Vanilla Arch Linux**:

1. **Download the Official ISO**:
   - Download the latest `archlinux-x86_64.iso` from [archlinux.org/download](https://archlinux.org/download/).
2. **Flash to USB**:
   - Using Rufus (DD mode), Ventoy, or `dd`:
     ```bash
     sudo dd bs=4M if=archlinux-*.iso of=/dev/sdX status=progress oflag=sync
     ```
3. **Boot into the Live Installer**:
   - Boot in UEFI mode.
   - Run the guided Arch installer:
     ```bash
     archinstall
     ```
4. **Recommended `archinstall` Settings for Pure Speed**:
   - **Profile**: Select `Minimal` (Do **NOT** select a Desktop Environment or Window Manager!).
   - **Audio**: Select `PipeWire`.
   - **Network configuration**: Select `NetworkManager`.
   - **Disk configuration**: Btrfs or ext4 (Btrfs with zstd compression recommended).
   - **User account**: Create your user account and grant **sudo (wheel)** access.
5. **Reboot**:
   - When finished, remove the USB drive and reboot into your fresh minimal Arch tty prompt.

---

## 🚀 Step 2: 1-Click Installation

Log in with your user account, then run:

```bash
# 1. Ensure git is installed
sudo pacman -S --needed --noconfirm git

# 2. Clone this repository
git clone https://github.com/bhjhmkpk-commits/arch-sway-workstation.git
cd arch-sway-workstation

# 3. Run the installer
./install.sh
```

The script will:
1. Install all required Sway, Waybar, Audio, and Media packages via `pacman`.
2. Deploy all dotfiles to `~/.config/` (Sway, Waybar, Foot, Wofi, Mako, Satty, MPV, Swaylock).
3. Deploy custom productivity scripts to `~/.local/bin/`.
4. Deploy crisp 512×512 web application icons.
5. Enable background systemd user services (`swayidle`, `cliphist`, `sway-wellbeing`).
6. Configure auto-login on `tty1` so Sway starts instantly without any display manager overhead.

---

## 🎹 Keyboard Shortcuts (Muscle Memory)

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| <kbd>Super</kbd> + <kbd>Enter</kbd> | **Foot Terminal** | Lightning-fast GPU-accelerated terminal |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>Enter</kbd> | **Tmux Work Session** | Persistent terminal session (`tmux -A -s Work`) |
| <kbd>Super</kbd> + <kbd>Space</kbd> / <kbd>D</kbd> | **Wofi Application Menu** | Fuzzy app launcher |
| <kbd>Super</kbd> + <kbd>W</kbd> | **Close Window** | Closes the active window |
| <kbd>Super</kbd> + <kbd>F</kbd> | **Fullscreen Toggle** | Toggles full-screen mode |
| <kbd>Super</kbd> + <kbd>T</kbd> | **Floating Toggle** | Toggles floating mode on active window |
| <kbd>Super</kbd> + <kbd>B</kbd> | **Chromium Browser** | Clean web browser & PWA runner |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd> | **Thunar File Manager** | Lightweight GUI file manager |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>F</kbd> | **Yazi Terminal FM** | Blazing-fast terminal file manager |
| <kbd>Print</kbd> | **Screenshot Full Screen** | Auto-copies to clipboard & opens Satty editor |
| <kbd>Shift</kbd> + <kbd>Print</kbd> | **Screenshot Area Drag** | Drag crosshair, auto-copies & opens Satty |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>V</kbd> | **Clipboard History** | Cliphist menu (with `[Clear History]` button) |
| <kbd>Super</kbd> + <kbd>Escape</kbd> | **System Monitor** | Terminal resource monitor (`btop`) |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>E</kbd> | **Wellbeing & Eye Care** | Break timer & SOT stats menu |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>E</kbd> | **Pause/Resume Eye Timer** | Quick toggle for break timer |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>A</kbd> | **Web App Manager** | Create standalone borderless PWAs |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> | **Reload Sway Live** | Reloads Sway and Waybar configs on the fly |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> | **Exit Sway Prompt** | Safe exit prompt |

---

## 🧰 Included Everyday Software Suite

- **Image Viewer**: `Viewnior` (lightweight C/GTK image viewer with crop, rotate, flip, and zoom).
- **Video Player**: `MPV` (hardware Intel/AMD VA-API acceleration, audio track switching with `a`/`Shift+A`).
- **Document & PDF Reader**: `Xreader` (multi-tab PDF/EPUB viewer).
- **Archive Manager**: `Xarchiver` + `unzip` + `7zip` (right-click Extract in Thunar).
- **Audio Routing**: `PipeWire` + `WirePlumber` + `pamixer` + `pavucontrol` (right-click Waybar volume icon).
- **Screenshots & Annotations**: `Satty` (smart floating window, yellow highlighter, arrows, text, blur tool).
- **Power Management**: `swayidle` 2-stage display sleep (turns off monitor after 5 min, locks after 15 min).

---

## 📊 Live Resource Consumption

```text
sway (Compositor)            : 79.9 MB
waybar (Status Bar)          : 52.1 MB
foot (Terminal)              : 36.2 MB
mako (Notification Daemon)   : 28.0 MB
NetworkManager               : 27.2 MB
pipewire & wireplumber       : 58.8 MB
systemd & base daemons       : 68.9 MB
swaybg & swayidle            : 10.4 MB
---------------------------------------------------
Total Core Desktop RAM       : ~354 MB
Idle CPU Load                : 0.0% – 0.5%
```
