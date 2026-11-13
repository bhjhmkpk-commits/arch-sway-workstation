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

## 💿 Step 1: Base Operating System & UEFI Setup

This workstation runs on **pure Vanilla Arch Linux** in native **64-bit UEFI** mode:

1. **Motherboard BIOS Settings (Verified Safe Baseline)**:
   - Enter BIOS (press <kbd>Del</kbd> or <kbd>F2</kbd> on startup).
   - Set **CSM Support** to **`Enabled`**.
   - Set **Video Option ROM** to **`Legacy`** *(⚠️ Never set Video to UEFI on HDMI to prevent black screens)*.
   - Set **Storage Option ROM** to **`UEFI`**.
   - Ensure **SATA Mode** is set to **`AHCI`**.
   - Secure Boot: **`Disabled`**.
   - For complete step-by-step instructions, see [**Clean Install & Dual-Boot Guide**](REINSTALL_DUALBOOT_GUIDE.md).
2. **Boot the Arch Linux USB in UEFI Mode**:
   - Press <kbd>F11</kbd> or <kbd>F12</kbd> for the boot menu and choose `UEFI: <Your USB Name>`.
3. **Launch the Installer**:
   ```bash
   archinstall
   ```
4. **Recommended `archinstall` Options (Single-Drive or Dual-Boot with Omarchy)**:
   - **Disk configuration**: Choose **Manual Partitioning** on your SSD (e.g. `/dev/sda`):
     - Partition Table: **`gpt`** (Wipe any legacy MBR table).
     - Partition 1: **`1024M`** (1 GiB) → Type: `EFI System Partition` → Mountpoint: `/boot` (FAT32).
     - Partition 2: **`110G`** → Type: `Linux filesystem` → Mountpoint: `/` (Filesystem: `btrfs` with default subvolumes).
     - **Remaining ~120 GB**: Leave as **Free / Unallocated Space** (for Omarchy!).
   - **Bootloader**: `systemd-boot` or `GRUB`.
   - **Profile**: `Minimal` (Do **NOT** select any desktop environment!).
   - **Audio**: `PipeWire`.
   - **Network configuration**: `NetworkManager`.
   - **User account**: Add user `bohar` with **sudo** privileges.
5. **Reboot**:
   - Remove the USB and reboot directly into your fast UEFI minimal terminal prompt.

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
6. Configure minimal `tuigreet` login manager (`greetd`).

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
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> | **Power Menu** | Instant Power Off, Reboot, or Logout |

---

## 🧰 Included Everyday Software Suite

- **Image Viewer**: `Viewnior` (lightweight C/GTK image viewer with crop, rotate, flip, and zoom).
- **Video Player**: `MPV` (hardware Intel/AMD VA-API acceleration, audio track switching with `a`/`Shift+A`).
- **Document & PDF Reader**: `Xreader` (multi-tab PDF/EPUB viewer).
- **Archive Manager**: `Xarchiver` + `unzip` + `7zip` (right-click Extract in Thunar).
- **Audio Routing**: `PipeWire` + `WirePlumber` + `pamixer` + `pavucontrol` (right-click Waybar volume icon).
- **Screenshots & Annotations**: `Satty` (smart floating window, yellow highlighter, arrows, text, blur tool).
- **Power Management**: `swayidle` 2-stage display sleep (turns off monitor after 5 min, locks after 15 min).
- **Safe Updates & Rollback**: `arch-update` & `arch-rollback` (automatic pre-update Btrfs snapshots, UKI verification, Arch news check, and 1-click restore).

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
