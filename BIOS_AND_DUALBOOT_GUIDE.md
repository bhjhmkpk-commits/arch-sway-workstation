# 📱 BIOS Optimization & Dual-Boot Guide (Phone Reference)

> **Quick Link for Your Phone**: View this guide formatted on GitHub at:  
> **[https://github.com/bhjhmkpk-commits/arch-sway-workstation/blob/main/BIOS_AND_DUALBOOT_GUIDE.md](https://github.com/bhjhmkpk-commits/arch-sway-workstation/blob/main/BIOS_AND_DUALBOOT_GUIDE.md)**

---

## 🖥️ System Hardware Profile

* **Motherboard**: Intel H310C (`BIOS 310CH602`, 64-bit UEFI)
* **CPU**: Intel Core i5-6400 (4 cores, 4 threads @ 2.70 GHz base – 3.30 GHz turbo)
* **GPU**: Intel HD Graphics 530 (Skylake GT2, native VA-API driver `i915`)
* **RAM**: 8 GB DDR4
* **Drive (`/dev/sda`)**: 256 GB SSD (`HS-SSD-E100 256G`, GPT partitioned)
  * `Partition 1` (`/dev/sda1`): 1.0 GiB FAT32 Shared EFI Bootloader (`/boot`)
  * `Partition 2` (`/dev/sda2`): 110 GiB Btrfs Arch Sway Workstation
  * `Free Space`: **127 GiB Unallocated** (Ready for Dual-Boot)

---

## ⚙️ Part 1: BIOS Settings & Performance Tweaks

Access your BIOS by pressing **`Del`** or **`F2`** as soon as the PC powers on.

### 1. 🚀 CPU & Frequency Boost (Peak 3.30 GHz)

| Setting | Recommended Value | Purpose |
| :--- | :--- | :--- |
| **Intel Turbo Boost Technology** | **`Enabled`** | Unlocks full 3.30 GHz dynamic clock under heavy compile/app load. |
| **Intel SpeedStep (EIST)** | **`Enabled`** | Hardware-level microsecond frequency scaling. |
| **Intel Speed Shift (HWP)** | **`Enabled`** | Allows CPU autonomous P-state transitions without OS latency. |
| **Power Limit 1 (PL1)** | **`65W`** (or Max) | Prevents sustained power-throttling on 4-core multi-threaded tasks. |
| **Power Limit 2 (PL2)** | **`65W`** (or Max) | Maximum short-burst turbo power. |

---

### 2. 🎮 Intel HD Graphics 530 (Smooth Wayland & VA-API)

| Setting | Recommended Value | Purpose |
| :--- | :--- | :--- |
| **DVMT Pre-Allocated Memory** | **`64MB`** or **`128MB`** | Pre-allocates VRAM buffer for Sway Wayland compositor & hardware video decode. |
| **DVMT Total Gfx Mem** | **`MAX`** (or 256MB) | Maximum dynamic memory pool for GPU tasks. |
| **Primary / Initial Display** | **`IGFX`** / **`Internal`** | Stops motherboard wasting 1–2s searching for an external PCIe GPU on boot. |

---

### 3. ⚡ Fast Boot & Boot Time Optimization (Shave ~4 Seconds)

| Setting | Recommended Value | Purpose |
| :--- | :--- | :--- |
| **Fast Boot / Quick Boot** | **`Enabled`** | Skips deep RAM self-checks and redundant USB polling on POST. |
| **POST Delay / Boot Delay Time** | **`0`** or **`1` second** | Minimizes pause before bootloader handoff. |
| **Network Stack / PXE ROM** | **`Disabled`** | Eliminates delay waiting for Ethernet network boot ROMs. |
| **Serial / COM Port (SuperIO)** | **`Disabled`** | Disables unused motherboard legacy RS232 headers (~300ms boot saving). |

---

### ⚠️ Critical Motherboard Rule (Prevent HDMI Black Screen)

> [!CAUTION]
> **Do NOT disable CSM or switch Video to UEFI!**  
> This specific H310C board will blackout on HDMI output if Video Option ROM is set to UEFI. Maintain this exact verified baseline:
> * **CSM Support**: `Enabled`
> * **Video Option ROM**: `Legacy` *(CRITICAL for HDMI)*
> * **Storage Option ROM**: `UEFI` *(Allows 64-bit UEFI loaders & systemd-boot)*
> * **SATA Mode**: `AHCI` *(Mandatory for SSD TRIM & speed)*
> * **Secure Boot**: `Disabled`

---

## 💿 Part 2: Dual-Booting into the 127 GiB Free Space

### Current Drive Layout (`/dev/sda`)

```text
┌─────────────────────────┬──────────────────────────────┬───────────────────────────┐
│ /dev/sda1 (1 GiB FAT32) │  /dev/sda2 (110 GiB Btrfs)   │    127 GiB FREE SPACE     │
│ Shared EFI Bootloader   │  Arch Sway Workstation (OS1) │   Ready for OS 2 (Empty)  │
└─────────────────────────┴──────────────────────────────┴───────────────────────────┘
```

---

### Step-by-Step Installation Workflow

#### Step 1: Boot the Installer ISO
1. Copy the ISO for your new operating system (e.g. **Omarchy**, **Fedora**, **Ubuntu**, etc.) to your **Ventoy USB**.
2. Plug the USB into your PC, power on, and tap **`F11`** to open the boot menu.
3. Select:
   ```text
   UEFI: Generic Flash Disk 8.07, Partition 2
   ```
4. In Ventoy, choose your ISO to launch the installer.

---

#### Step 2: Disk Partitioning (Crucial Safety Rules)

> [!IMPORTANT]
> **NEVER select "Erase Disk", "Replace Partition", or "Automatic / Entire Drive"**. Doing so will wipe your Arch Sway installation.

1. Select **Manual Partitioning** (or **"Install into Free Space"**).
2. You will see:
   * `/dev/sda1` (1024 MB, FAT32)
   * `/dev/sda2` (110 GB, Btrfs)
   * `Free Space` (~127 GB)
3. **Configure Shared EFI Partition (`/dev/sda1`)**:
   * Mountpoint: `/boot/efi` (or `/boot`)
   * **FORMAT FLAG**: **DO NOT FORMAT (UNCHECK FORMAT)**  
     *(Unchecking format preserves Arch Sway's `arch-linux.efi` bootloader!)*
4. **Create Root Partition for New OS**:
   * Click on the **127 GiB Free Space**.
   * Click **Create / Add Partition**.
   * Size: `100%` (fill the rest of the disk, ~127 GB).
   * Filesystem: `btrfs` or `ext4` (with optional LUKS encryption).
   * Mountpoint: `/`.
5. Finish user/password configuration and complete the installation.

---

### 🔀 Step 3: How to Switch Between Operating Systems

1. **Motherboard Boot Menu (`F11`)**:
   * Press **`F11`** at power-on.
   * Both systems will show in your BIOS NVRAM:
     * `Linux Boot Manager` $\rightarrow$ **Arch Sway Workstation**
     * `Omarchy` / `<New OS Name>` $\rightarrow$ **Second OS**
2. **`systemd-boot` Menu Selection**:
   * During the 1-second startup countdown, tap **`Space`** to show the boot menu.
   * Press **`d`** on any highlighted entry to set it as your permanent default OS.

---

## 🔄 Reclaiming the 127 GiB Free Space Anytime

If you later decide to delete the second OS and return the entire 256 GB drive to Arch Sway:

1. **Delete Partition 3**:
   ```bash
   sudo fdisk /dev/sda
   # Press 'd', select partition 3, press 'w' to save and exit
   ```
2. **Expand Partition 2 & Btrfs Filesystem**:
   ```bash
   sudo parted /dev/sda resizepart 2 100%
   sudo btrfs filesystem resize max /
   ```
*Your Arch Sway system will instantly expand from 110 GiB to the full **238 GiB** with zero data loss and no restart required.*
