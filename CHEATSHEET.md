# 🚀 Arch Sway Workstation — Cheat Sheet & Power User Guide

> **Quick Invocation:**
> * Press **`$mod + k`** anywhere in Sway to launch the **Interactive Cheatsheet HUD & Launcher**.
> * Type **`guide`** or **`cheat`** in any terminal for instant CLI reference.

---

## 🎓 1. Student, Academic & Document Tools

| Action | Shortcut / Command | Tool | Purpose |
| :--- | :--- | :--- | :--- |
| **Instant Screen OCR** | **`$mod + Shift + o`** or **`Alt + Print`** | `ocr-grab` + `tesseract` | Drag a box over any un-copyable lecture slide, video, or PDF → copies extracted text straight to clipboard. |
| **PDF Annotation & Notes** | Open via Wofi or `xournalpp` | `Xournal++` | Handwriting, highlighting, typing notes, drawing formulas, and signing PDF application forms. |
| **PDF Split, Merge & Crop** | Open via Wofi or `pdfarranger` | `PDF Arranger` | Visual drag-and-drop tool to rotate, split, merge, and crop PDF pages. |
| **Math & Physics Engine** | `calc "<expr>"` | `libqalculate` (`qalc`) | Symbolic math, calculus, physical constants, and unit conversions (e.g., `calc "50 USD in INR"`, `calc "2.5 eV in J"`). |
| **Desktop Calculator** | Open via Wofi or `galculator` | `galculator` | Lightweight GTK scientific calculator with algebraic and memory registers. |
| **Quick Text Notes** | Open via Wofi or `mousepad` | `mousepad` | Fast GUI tabbed text editor with syntax highlighting for quick scratchpads. |

---

## 📱 2. Android & Mobile Utilities

| Action | Command / Shortcut | Tool | Purpose |
| :--- | :--- | :--- | :--- |
| **Wi-Fi File Drop (QR Code)** | `share-wifi [file]` | `share-wifi` + `qrencode` | Generates a terminal QR code. Scan with your phone camera to download files over local Wi-Fi without cables or cloud apps. |
| **Android Screen Mirroring** | `scrcpy` | `scrcpy` | 60fps low-latency screen mirror, audio forwarding, and keyboard/mouse control over USB or Wi-Fi. |
| **Universal Debloater** | Open via Wofi or `uad-ng` | `universal-android-debloater` | Connect phone via ADB to safely remove or disable manufacturer/carrier bloatware. |
| **USB File Transfer (MTP)** | Open `Thunar` | `gvfs-mtp` | Plug in your phone via USB and browse internal storage directly in Thunar. |

---

## 💾 3. USB, Disks & Storage Management

| Action | Command / Shortcut | Tool | Purpose |
| :--- | :--- | :--- | :--- |
| **Disks GUI** | Open via Wofi or `gnome-disks` | `gnome-disk-utility` | Format drives (FAT32, exFAT, NTFS, ext4), burn/restore ISO images to USB, and check SMART health. |
| **Multi-Boot USB Drive** | `ventoygui` | `ventoy-bin` | Format a USB flash drive once; drag and drop multiple Linux/Windows ISOs to boot any of them interactively. |
| **Inspect USB Hardware** | `lsusb` | `usbutils` | List all connected USB devices, vendor IDs, and hub controllers. |
| **Interactive Storage Space** | `gdu ~` | `gdu` | Lightning-fast, interactive arrow-key terminal disk usage analyzer. |

---

## 💻 4. Developer, Linux & Terminal Workflows

| Action | Command | Purpose |
| :--- | :--- | :--- |
| **Smart Directory Jump** | `z <partial-name>` | Learns folder habits. E.g., `z jam` jumps to `~/IIT JAM 2027`, `z sway` jumps to workstation repo. |
| **Git Visual TUI** | `lg` | Full keyboard-driven interface for git commits, staging individual lines, diffs, and branch rebasing. |
| **Fast Command Cheats** | `tldr <cmd>` | Real-world, practical usage examples (e.g., `tldr tar`, `tldr pacman`, `tldr adb`). |
| **Syntax-Highlighted Cat** | `cat <file>` | Blazing fast colored file preview with line numbers powered by `bat`. |
| **Paginated Git Diff View** | `catp <file>` | Full paginated viewer showing Git additions/deletions in the margin. |
| **Isolated Python/AI Runner**| `uv run <script.py>` | Runs single-file Python scripts in isolated sandboxes without polluting system packages. |
| **Script Bug Checker** | `shellcheck <script>` | Static analysis to find unquoted variables and syntax bugs in bash scripts. |

---

## 🖥️ 5. Sway Desktop & Window Manager Keybindings

| Keybinding | Action |
| :--- | :--- |
| **`$mod + k`** / **`$mod + F1`** | **Open Interactive Cheatsheet HUD & Action Launcher** |
| **`$mod + d`** / **`$mod + Space`** | Application launcher (`wofi`) |
| **`$mod + Return`** | Open Foot terminal |
| **`$mod + Alt + Return`** | Open Persistent Tmux Work session |
| **`$mod + Shift + v`** | Open Clipboard History Menu (`cliphist`) |
| **`$mod + Escape`** | Open System & Resource Monitor (`btop`) |
| **`$mod + b`** | Launch Chromium web browser |
| **`$mod + Shift + b`** | Launch Brave Origin web browser |
| **`$mod + w`** | Close / Kill focused window |
| **`$mod + f`** | Toggle Fullscreen |
| **`$mod + t`** | Toggle Floating mode |
| **`$mod + Shift + r`** | Reload Sway compositor configuration |
| **`$mod + Backspace`** / **`$mod + Ctrl + l`** | Lock screen (`swaylock`) |
| **`Print`** | Full screen screenshot (opens in `satty`) |
| **`Shift + Print`** | Selected area screenshot (opens in `satty`) |
| **`$mod + Shift + o`** / **`Alt + Print`** | Extract text from screen to clipboard (OCR) |
| **`$mod + Arrow Keys`** | Focus window (Left, Down, Up, Right) |
| **`$mod + Shift + Arrow Keys`** | Move window (Left, Down, Up, Right) |
| **`$mod + 1-10`** | Switch to Workspace 1–10 |
| **`$mod + Shift + 1-10`** | Move container to Workspace 1–10 |
