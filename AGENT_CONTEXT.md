# 🧠 Arch Sway Workstation — Master Agent Context & System Memory

> **Purpose for AI Assistants**: This document is the persistent context, architecture guide, and decision memory for AI coding agents (such as Google Antigravity / AGY) working on this workstation. When starting a fresh session on this machine, read this file to immediately understand the system state, user preferences, custom tools, and past troubleshooting history without starting from scratch.

---

## 👤 User Profile & Philosophy

* **User**: Bohar Singh (`bohar`)
* **Role**: Student & Computer Science / AI enthusiast.
* **Core Philosophy**:
  1. **Minimal & Clean**: Zero bloatware, zero background daemon clutter, zero unused packages.
  2. **High Performance**: Maximize CPU performance governor, ZRAM swappiness=180, fastest possible boot (~3–5s) and instant poweroff.
  3. **Eye Health & Distraction-Free**: Everforest dark/warm aesthetic, blue-light filtering, screen-on-time (SOT) tracking, 20-20-20 eye rest intervals.
  4. **Productive Ecosystem**: Rich, accessible utilities for PDFs, handwritten notes, OCR, phone-to-PC bridging, and AI web applications.

---

## 🖥️ Hardware Specifications

* **Motherboard**: Intel H310C (`BIOS 310CH602`, supports 64-bit UEFI)
* **CPU**: Intel Core i5-6400 (4 cores, 4 threads @ 2.70 GHz - 3.30 GHz)
* **GPU**: Intel HD Graphics 530 (Skylake-S GT2, driver: `i915`, native VA-API hardware acceleration)
* **Memory**: 8 GB DDR4 RAM + 3.8 GB ZRAM (`zram-generator`)
* **Storage**: 256 GB SSD (`HS-SSD-E100 256G`)
* **Target Partition Scheme (UEFI / GPT Dual-Boot)**:
  * `/dev/sda1` (1 GiB, FAT32): Shared EFI System Partition (`/boot`)
  * `/dev/sda2` (~110 GiB, Btrfs): Arch Sway Workstation (`@`, `@home`, `@log`, `@pkg`)
  * `/dev/sda3` (~120 GiB, LUKS Btrfs): Omarchy (Hyprland developer distro)
* **Network Interfaces**:
  * Ethernet: `enp2s0` (Primary active connection)
  * Wi-Fi: `wlp0s20f0u4` (USB wireless dongle, managed via NetworkManager / `nmtui`)

---

## 🛠️ Complete Workstation Stack

| Component | Software | Role / Configuration Notes |
| :--- | :--- | :--- |
| **Compositor** | `sway` | Wayland tiling window manager, Everforest theme, 1px borders |
| **Bar / Status** | `waybar` | Custom modules: Wellbeing, Brightness, Nightlight, Audio, Network, CPU, RAM |
| **Terminal** | `foot` | GPU-accelerated, lightweight, Everforest color scheme |
| **App Launcher** | `wofi` | Clean rounded Everforest menus (`drun`, `cheatsheet`, `keysheet`) |
| **Notifications** | `mako` | Clean Everforest notifications with action buttons |
| **Display Manager** | `greetd` + `tuigreet` | Console-based Rust greeter (`vt = 1`), loads in <1ms |
| **Audio Subsystem**| `pipewire` + `wireplumber` | Modern Wayland audio with `pamixer` & `pavucontrol` |
| **File Manager** | `thunar` + `yazi` | GUI Thunar (with safe launcher) & terminal Yazi (floating `$mod+Alt+f`) |
| **Image & Video** | `viewnior` & `mpv` | Hardware accelerated (Intel VA-API), multi-audio track switcher |
| **Documents** | `xreader` & `xournalpp` | Multi-tab PDF/EPUB viewer & lecture note handwritten annotator |
| **PDF Tools** | `pdfarranger` | Drag-and-drop PDF page merge, split, crop, and rotate |
| **Clipboard** | `cliphist` + `wl-paste` | Searchable clipboard history menu (`$mod+Shift+v`) |
| **Screen Capture** | `satty` + `grim` + `slurp`| Interactive screenshot annotation tool with highlighter, arrows, blur |

---

## 📱 Custom Built Utilities & Scripts (`~/.local/bin/`)

1. **Wireless Phone Storage (`phone-mount`)**:
   * Mounts Android Wi-Fi FTP/SFTP server to `~/Phone` via `rclone` VFS cache engine.
   * **Auto-Disconnect Watchdog**: Pings the phone socket every 4s. Automatically unmounts `~/Phone` when the phone server stops.
   * **Safe Thunar Launcher (`thunar`)**: Wrapper in `~/.local/bin/thunar` checks if `~/Phone` is unresponsive (<0.5s) and auto-cleans it before Thunar opens. Thunar can never freeze.
   * Hotkey: `$mod + Ctrl + m` (Connect) • `$mod + Ctrl + Shift + m` (Disconnect).
2. **2-Way Phone Clipboard Bridge (`phone-clip`)**:
   * Generates a local QR code on port 8088. Phone camera scans it to instantly push/pull clipboard text across devices with zero phone apps required.
   * Hotkey: `$mod + Ctrl + p`.
3. **Screen OCR Text Grabber (`ocr-grab`)**:
   * Drag crosshair over any image, video, or lecture slide; uses Tesseract OCR to extract text directly into clipboard.
   * Hotkey: `$mod + Shift + o` or `Alt + Print`.
4. **Universal Copy & Paste (`universal-copy`, `universal-paste`)**:
   * Unified hotkeys (`$mod + c` and `$mod + v`) that work seamlessly across both terminal windows and GUI applications.
5. **Interactive HUD & Cheat Sheet (`cheatsheet-menu`, `keysheet-menu`, `guide`)**:
   * `$mod + k`: Interactive Wofi HUD showing what tools exist, what they do, and launches them.
   * `$mod + /`: Searchable fuzzy-finder for all workstation keybindings.
   * `guide` / `cheat`: Terminal CLI quick-reference card.
6. **Eye Health & Screen Time (`sway-wellbeing`)**:
   * Tracks screen-on time (SOT) and enforces 20-20-20 eye strain breaks with audio chime and countdown.
   * Hotkey: `$mod + Alt + e`.
7. **Monitor Brightness & Blue Light Control (`brightness-ctrl`, `nightlight`)**:
   * Controls external desktop monitor via DDC/CI (`ddcutil` / `i2c-dev`) without root permissions.
   * Smooth blue light warmth filtering via `wlsunset`.
   * Hotkeys: `$mod + n` (Toggle night light) • `$mod + Shift + n` (Cycle warmth).
8. **Web Application PWA Suite (`webapp`)**:
   * Standalone, borderless native web apps powered by `brave-origin --app` (shares logins with Brave, native ad-blocking via Shields, VA-API hardware acceleration) with custom 512×512 icons:
   * Gemini (`$mod+Alt+g`), ChatGPT (`$mod+Alt+c`), Claude (`$mod+Alt+k`), WhatsApp (`$mod+Alt+w`), Gmail (`$mod+Alt+m`), YouTube (`$mod+Shift+y`), YouTube Music (`$mod+Shift+m`), YT-DLP Menu (`$mod+y`).

---

## ⚡ Key Architectural Decisions & Past Troubleshooting

### 1. Memory Accounting (btop ~940 MB vs 580 MB process sum)
* **The Root Cause**: Summing visible processes misses the long tail of ~130 small background daemons/threads (taking 1–3 MB each = ~260 MB).
* Additionally, Linux kernel memory (`Slab` ~120 MB, `PageTables` ~15 MB, Wayland GPU buffers) is not owned by any single PID.
* **Conclusion**: ~940 MB at idle is exceptionally lean for a modern Wayland desktop; no further aggressive stripping is needed.

### 2. Fast & Clean Poweroff / Shutdown
* **Issue**: Abrupt `shutdown now` caused Sway to kill clients, triggering broken pipe errors in `cliphist` (`exit-code 1`) and alarming udev `destructive transaction (ignoring)` logs.
* **Fixes Applied**:
  * Set `SuccessExitStatus=1 141` in `~/.config/systemd/user/cliphist.service`.
  * Set `DefaultTimeoutStopSec=10s` and `DefaultTimeoutAbortSec=10s` in `/etc/systemd/system.conf.d/timeout.conf` and user configs (down from 90s).
  * Added shell aliases in `~/.bashrc`:
    ```bash
    alias shutdown='systemctl poweroff -i'
    alias poweroff='systemctl poweroff -i'
    alias reboot='systemctl reboot -i'
    ```
  * Added instant Power Menu in Sway (`$mod + Shift + e`).

### 3. Desktop PC Optimization: No-Battery Power Management
* Because this is a desktop PC with no internal battery, `upowerd` was only polling non-existent batteries.
* Masked `upower.service` (`systemctl mask upower`), saving ~11 MB RAM and ~230ms of boot time.

### 4. Boot Optimization (Legacy BIOS vs UEFI)
* **Discovered Issue**: System was booted in Legacy BIOS (MBR table on `/dev/sda`). In Legacy BIOS, disk I/O uses 16-bit real-mode `INT 13h` (~10–15 MB/s), causing the noticeable `Loading initial ramdisk...` pause.
* **Temporary BIOS Fixes Applied**:
  * Silenced GRUB loading messages in `/etc/grub.d/10_linux`.
  * Set `GRUB_EARLY_INITRD_LINUX_STOCK="none"` to eliminate duplicate 16 MB `intel-ucode.img` disk read (already embedded in initramfs).
  * Reduced `GRUB_TIMEOUT=1` (saved 4s).
  * Enabled Early KMS with `MODULES=(i915)` in `/etc/mkinitcpio.conf`.
  * Disabled `NetworkManager-wait-online.service`.
  * Set `/boot` to automount on-demand (`noauto,x-systemd.automount`).
* **Permanent Solution**: Reinstalling in native **64-bit UEFI with GPT** to enable dual-booting with **Omarchy** and unlock 500+ MB/s SSD boot speeds.

### 5. Wireless Phone Storage & Rclone VFS Deadlock Prevention
* **CRITICAL RULE**: **NEVER set `--buffer-size > 0` when using `--vfs-cache-mode full`.**
* **The Root Cause of Thunar Freezes**:
  * An in-memory buffer (`--buffer-size 32M`) activates rclone's `AsyncReader`.
  * When Thunar or Tumbler requests metadata/thumbnails for multiple files concurrently, `AsyncReader.StopBuffering()` and `downloader.stopAndClose()` deadlock on internal mutex lock (`internal/sync.(*Mutex).lockSlow`).
  * The Linux kernel puts Thunar into an uninterruptible sleep (`D` state in `folio_wait_bit_common`), freezing the GUI.
* **Permanent High-Performance Configuration**:
  * `--buffer-size 0`: Absolutely mandatory to disable `AsyncReader` and eliminate the deadlock.
  * `--vfs-read-chunk-size 16M` + `--vfs-read-chunk-size-limit off`: Fast disk-cached streaming without hundreds of tiny 2MB requests.
  * `--ftp-concurrency 2` + `--transfers 1` + `--checkers 1`: Prevents Android FTP socket collisions and dropped connection copy errors.
  * `--timeout 45s` + `--contimeout 15s` + `--low-level-retries 10`: Resilient against Wi-Fi packet drops without throwing copy errors.
  * `--dir-cache-time 15m` + `--attr-timeout 10m`: Fast instant directory navigation.
  * Thunar `/misc-thumbnail-max-file-size 20971520` (20MB): Prevents Tumbler from choking the FTP connection on large video files.

### 6. Silent & Instant UKI Boot (Straight to Login Screen)
* **Goal**: Zero bootloader menu wait, zero scrolling kernel/systemd text, zero splash interruption—seamless transition straight to `tuigreet` login screen.
* **Configurations Applied**:
  * `/boot/loader/loader.conf`: Set `timeout 0` and `console-mode max` to bypass the systemd-boot countdown entirely (hold `Space` on boot if manual menu is ever needed).
  * `/etc/kernel/cmdline`: Embedded `quiet loglevel=3 systemd.show_status=auto rd.udev.log_level=3 vt.global_cursor_default=0` to silence kernel device probes and systemd `[ OK ]` status lines.
  * `/etc/mkinitcpio.conf`: Enforced Early KMS with `MODULES=(i915)` so Intel HD 530 modesets immediately without text-mode jumping or display flicker.
  * `/etc/mkinitcpio.d/linux.preset`: Removed `--splash` bitmap.
  * Regenerated atomic Unified Kernel Image: `/boot/EFI/Linux/arch-linux.efi`.
  * Enabled `arch-linux-fallback.efi` preset in `/etc/mkinitcpio.d/linux.preset` with `-S autodetect` for disaster recovery.
  * Created `@snapshots` Btrfs subvolume mounted at `/.snapshots` (`chmod 700`) with fstab integration.
  * Added `arch-update` & `arch-rollback`: Custom safe update utility with pre-flight checks, Arch news checks, atomic Btrfs snapshotting, UKI backup, AUR sync, and 1-click rollback.

### 7. Dual-Browser Architecture & Web App Ecosystem
* **Default Privacy & Workhorse Browser**: Brave Browser (`brave-origin`) is the system default (`$mod + b`), configured via `xdg-settings` and `~/.config/mimeapps.list`. Provides built-in Shields ad-blocking (including YouTube video ads), Brave Sync across devices, and native Wayland hardware video decoding via Intel VA-API (`VaapiVideoDecodeLinuxGL`).
* **Secondary Clean Browser**: Chromium is bound directly to `$mod + Shift + c` for isolated testing and fallback browsing. Direct Brave launch is on `$mod + Shift + b`.
* **PWA / Web App Suite (`webapp`)**: Powered by `brave-origin --app="..."`. Web apps (YouTube, YouTube Music, ChatGPT, Claude, Gemini, WhatsApp Web, Gmail, Reddit, GitHub, Calendar) share cookies, login sessions, and Shields ad-blocking with Brave, eliminating duplicate logins and ads while running in lightweight, standalone windows without browser chrome.

---

## 🔄 Reinstall & 1-Click Restoration Workflow

To restore this workstation on a fresh Arch install:
```bash
# 1. Install git
sudo pacman -S --needed --noconfirm git

# 2. Clone the repository
git clone https://github.com/bhjhmkpk-commits/arch-sway-workstation.git
cd arch-sway-workstation

# 3. Run the automated installer
./install.sh
```

### 4. Restoring Past AGY Chats & Database History
If restoring the full historical CLI conversations from your phone backup (`agy_conversations_backup.tar.gz`):
```bash
mkdir -p ~/.gemini
tar -xzvf ~/Downloads/agy_conversations_backup.tar.gz -C ~/.gemini/
agy auth login
```
This restores all past conversation threads, SQLite summaries database, and transcripts.

---

## 🤖 Instructions for AI Assistants
* **Never add heavy bloatware** (Electron desktop wrappers, heavy desktop managers like GDM/SDDM, or background file indexers like Baloo/Tracker).
* **Respect the Everforest Palette**: Foreground `#d3c6aa`, Background `#2d353b` (dark) / `#232a2e` (black), Green `#a7c080`, Yellow `#dbbc7f`, Red `#e67e80`, Cyan `#7fbbb3`.
* **Preserve documentation integrity**: Always keep `CHEATSHEET.md`, `keysheet-menu`, and `guide` in sync whenever new shortcuts or tools are added.
* **Commit & Push**: All workstation code lives in the GitHub repository `bhjhmkpk-commits/arch-sway-workstation`.
