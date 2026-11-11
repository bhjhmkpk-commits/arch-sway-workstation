# 🚀 Clean Install & Dual-Boot Guide: Arch Sway + Omarchy (UEFI)

> **For Your Phone**: Open this file on your phone or view it on GitHub at [bhjhmkpk-commits/arch-sway-workstation](https://github.com/bhjhmkpk-commits/arch-sway-workstation) while performing the installation.

---

## 📋 Pre-Flight Checklist

1. **Backups Confirmed**:
   - Your AGY chat backup (`agy_conversations_backup.tar.gz`) is safely copied to your phone.
   - Any personal PDFs, documents, or photos are copied to your phone or external storage.
2. **Workstation Configs Safe on GitHub**:
   - Your complete Arch Sway setup is safely hosted at:
     `https://github.com/bhjhmkpk-commits/arch-sway-workstation.git`
3. **Bootable USBs Ready**:
   - Ventoy USB with:
     - Standard **Arch Linux ISO** (e.g. `archlinux-*.iso`)
     - **Omarchy ISO** (from [omarchy.org](https://omarchy.org))

---

## ⚙️ Step 1: Motherboard BIOS Settings (Verified Safe Baseline)

Do **NOT** disable CSM or set Video to UEFI (that is what caused the HDMI black screen previously). Use this exact verified baseline:

| BIOS Setting | Required Value | Why |
| :--- | :--- | :--- |
| **CSM Support** | **`Enabled`** | Keeps the legacy video compatibility wrapper active |
| **Video Option ROM** | **`Legacy`** | **CRITICAL**: Drives HDMI display without blackouts |
| **Storage Option ROM**| **`UEFI`** | Allows 64-bit UEFI OS loaders & NVRAM access |
| **SATA Mode** | **`AHCI`** | Full SATA SSD performance and TRIM |
| **Secure Boot** | **`Disabled`** | Required for Arch Linux & Omarchy |

> [!TIP]
> Since you just completed the UEFI test with these exact settings and saw `UEFI BOOT CONFIRMED`, your BIOS is already configured properly! You do not need to change anything in BIOS.

---

## 💿 Step 2: Install Arch Linux (Sway Base) via `archinstall`

1. Plug in your **Ventoy USB**.
2. Power on the PC and press **`F11`** (or **`Del`** $\rightarrow$ `Save & Exit` $\rightarrow$ `Boot Override`).
3. Select the entry:
   ```text
   UEFI: Generic Flash Disk 8.07, Partition 2
   ```
4. In the Ventoy menu, launch the **Arch Linux ISO** in normal mode.
5. At the `root@archiso ~#` prompt, launch the installer:
   ```bash
   archinstall
   ```

### Recommended `archinstall` Options:

1. **Locales / Keyboard**:
   - Keyboard: `us`
   - Locale: `en_US.UTF-8`
2. **Mirrors**:
   - Country: `India` (or your nearest mirror)
3. **Disk Configuration $\rightarrow$ Manual Partitioning**:
   - Select your 256GB SSD: **`/dev/sda`** (Hikvision `HS-SSD-E100 256G`).
   - Create a **`gpt`** partition table (or wipe `/dev/sda` to GPT).
   - **Create Partition 1 (Shared EFI Bootloader)**:
     - Size: `1024M` (1 GiB)
     - Type: `EFI System Partition` (FAT32)
     - Mountpoint: `/boot`
     - Boot flag: `yes` / `esp`
   - **Create Partition 2 (Arch Sway Workstation)**:
     - Size: `110G`
     - Type: `Linux filesystem`
     - Filesystem: `btrfs` (with subvolumes `@`, `@home`, `@log`, `@pkg`) or `ext4`
     - Mountpoint: `/`
   - **Remaining Space (~127 GiB)**:
     - ⚠️ **LEAVE COMPLETELY EMPTY / UNALLOCATED**.
     - Do **not** create a partition here. Omarchy will claim this free space and set up its LUKS encrypted container!
   - Save and exit the disk partitioning screen.
4. **Bootloader**:
   - Select **`systemd-boot`** or **`GRUB`** (both work with UEFI).
5. **Profile**:
   - Select **`Minimal`** *(Do NOT choose desktop Sway from archinstall; our custom repository installer sets up the full Everforest workstation with all custom tools)*.
6. **Audio**:
   - Select **`PipeWire`**.
7. **Network Configuration**:
   - Select **`NetworkManager`**.
8. **User Account**:
   - Username: `bohar`
   - Password: `bohars`
   - Superuser (sudo): **Yes**
   - Root password: (set to `bohars` or leave blank to disable root password)
9. **Disk Encryption**:
   - None (keeps Arch Sway booting instantly in ~3 seconds; Omarchy will have its own LUKS encryption).
10. **Install**:
    - Select **Install** and wait for packages to download and install.
    - When prompted "Would you like to chroot into the newly created installation?", select **No**.
    - Type `reboot` and unplug the USB.

---

## 🌿 Step 3: Restore Your Arch Sway Workstation (1-Click)

1. Turn on the PC and boot into your new Arch Linux system.
2. Log in with user `bohar`.
3. If using Wi-Fi, connect to your network:
   ```bash
   nmtui
   ```
   *(If on Ethernet, you are already online. Verify with `ping -c 3 archlinux.org`)*.
4. Run this single command to clone and install your complete workstation:
   ```bash
   sudo pacman -S --needed --noconfirm git
   git clone https://github.com/bhjhmkpk-commits/arch-sway-workstation.git ~/Projects/arch-sway-workstation
   cd ~/Projects/arch-sway-workstation
   ./install.sh
   ```
5. What the installer automatically does:
   - Installs all core packages: Sway, Waybar, Foot, Wofi, Satty, Mako, Thunar, Yazi, MPV, Viewnior, Xreader, Xournal++, PDF Arranger, Cliphist, Tesseract OCR.
   - Installs Intel hardware acceleration drivers (`intel-media-driver`, `vulkan-intel`).
   - Configures `greetd` + `tuigreet` console login manager.
   - Deploys all custom scripts in `~/.local/bin/` (phone-mount with auto-watchdog, phone-clip QR bridge, ocr-grab, brightness-ctrl, nightlight, sway-wellbeing).
   - Configures the Everforest theme, hotkeys, and power menu (`$mod+Shift+e`).
   - Sets up shutdown timeouts (10s) and fast power aliases.
6. When the script finishes, reboot:
   ```bash
   reboot
   ```
   You will land right into your `tuigreet` login screen and your familiar Sway desktop!

---

## 🧠 Step 4: Restore AGY (Antigravity CLI) Chats & Context

1. **Install the Antigravity CLI** (`agy`) if not already present.
2. **Transfer Chat Backup from Your Phone**:
   - Option A (USB Cable): Plug phone via USB, set to "File Transfer (MTP)", copy `agy_conversations_backup.tar.gz` to `~/Downloads/`.
   - Option B (Wi-Fi FTP): Start FTP server on phone, run `$mod + Ctrl + m` to mount `~/Phone`, copy `~/Phone/.../agy_conversations_backup.tar.gz` to `~/Downloads/`.
3. **Restore Conversations**:
   ```bash
   mkdir -p ~/.gemini/antigravity-cli/brain
   tar -xzf ~/Downloads/agy_conversations_backup.tar.gz -C ~/.gemini/antigravity-cli/brain/
   ```
4. **Log in**:
   ```bash
   agy auth login
   ```
5. **Feed Master Context**:
   When opening an AGY session in `~/Projects/arch-sway-workstation`, simply instruct the agent:
   > *"Read AGENT_CONTEXT.md for system context."*
   The agent will immediately have full memory of all past decisions, hardware specs, and custom configurations.

---

## 🎨 Step 5: Install Omarchy (Dual-Boot into Free Space)

1. Plug in your **Ventoy USB**.
2. Reboot and select **`UEFI: Generic Flash Disk 8.07, Partition 2`**.
3. In the Ventoy menu, select the **Omarchy ISO**.
4. In the Omarchy installer:
   - When prompted for disk destination, choose **"Install into free space"** (or select the empty ~127 GiB unallocated space).
   - ⚠️ **DO NOT SELECT "Erase Disk" or "Wipe Drive"** — make sure it uses only the unallocated free space!
   - Enter your desired LUKS passphrase for disk encryption.
   - Allow Omarchy to complete its installation.
5. Reboot when finished.

---

## 🏁 Result: Perfect Dual-Boot Workstation

At power-on, your motherboard's UEFI boot menu will offer:
* **Arch Linux** $\rightarrow$ Ultra-lean (~350 MB RAM, 0% CPU) Everforest Sway Workstation for daily coding & deep work.
* **Omarchy** $\rightarrow$ Modern, LUKS-encrypted Hyprland developer distribution.

---

## 🔄 Future Flexibility: Reclaiming the Free Space Anytime

If in the future you decide you no longer need Omarchy (or don't want a dual boot) and want the entire 256 GB drive dedicated solely to Arch Sway, you can reclaim the space in 5 seconds without rebooting:

1. **Delete the Omarchy partition** (Partition 3) using `fdisk` or `gnome-disk-utility`:
   ```bash
   sudo fdisk /dev/sda # (delete partition 3, save with w)
   ```
2. **Grow Partition 2 and expand Btrfs**:
   ```bash
   sudo parted /dev/sda resizepart 2 100%
   sudo btrfs filesystem resize max /
   ```
3. Done! Your Arch Sway system instantly expands from 110 GiB to the full 238.5 GiB with zero data loss.
