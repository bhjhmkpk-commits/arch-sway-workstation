# 🚀 Arch Sway Workstation — Cheat Sheet & Power User Guide

> **Quick Access Shortcuts:**
> * Press **`$mod + k`** anywhere in Sway to launch the **Interactive Utility Chart & Guide** (what we have, what it's for, and how to use it).
> * Press **`$mod + /`** (or **`$mod + ?`** / **`$mod + F1`**) to launch the **Searchable Keybinding Finder** (search any function or stock/custom shortcut).
> * Type **`guide`** or **`cheat`** in any terminal for instant CLI reference.

---

## ⌨️ Complete Keybinding Quick Reference

| Domain | Action / Tool | Shortcut / Keybind | Notes |
| :--- | :--- | :--- | :--- |
| **HUD** | **Utility Chart & Guide** | **`$mod + k`** | Educational chart form guide; Enter launches tool |
| **HUD** | **Searchable Keybinding Sheet** | **`$mod + /`** or **`$mod + ?`** | Search any action/shortcut; Enter triggers it |
| **Launcher**| Application Search (Wofi) | **`$mod + d`** or **`$mod + Space`** | Native Wayland application menu |
| **Terminal**| Foot Terminal | **`$mod + Return`** | Blazing-fast GPU-accelerated terminal |
| **Terminal**| Persistent Tmux Work Session | **`$mod + Alt + Return`** | Re-attaches to background workspace |
| **Clipboard**| Clipboard History (Cliphist) | **`$mod + Shift + v`** | Search, paste, or wipe clipboard |
| **Monitor** | System & Task Monitor (Btop) | **`$mod + Escape`** | CPU, GPU, RAM, Disks, Networks |
| **Browser** | Chromium Browser | **`$mod + b`** | Default Web Browser |
| **Browser** | Brave Origin Nightly | **`$mod + Shift + b`** | Secondary Ad-blocking Browser |
| **Files**   | Graphical File Manager (Thunar)| **`$mod + Shift + f`** | Thunar GUI with MTP phone browsing |
| **Files**   | Terminal File Manager (Yazi) | **`$mod + Alt + f`** | Fast terminal file manager with image previews |
| **PDF**     | Annotate & Sign (Xournal++) | **`$mod + p`** | Lecture notes, PDF highlighting, signing |
| **PDF**     | Split, Merge & Crop (PDF Arranger)| **`$mod + Shift + p`** | Drag & drop PDF page manipulator |
| **Math**    | Scientific Calculator (Galculator)| **`$mod + c`** | GTK scientific desktop calculator |
| **Math**    | Physics, Calculus & Currency | `calc "<expr>"` | E.g. `calc "50 USD in INR"`, `calc "2.5 eV in J"` |
| **Image**   | Image Editor & Cropper (Pinta)| **`$mod + i`** | Paint.NET alternative: crop, retouch, layers |
| **Notes**   | Quick GUI Text Notes (Mousepad)| **`$mod + m`** | Fast tabbed text editor with syntax highlighting |
| **Git**     | Interactive Git TUI (LazyGit) | **`$mod + g`** | Stage lines, commit, branch, diffs (`lg`) |
| **USB**     | Disks & ISO Burner (GNOME Disks)| **`$mod + u`** | Format (FAT32/exFAT/NTFS) & flash ISO to USB |
| **USB**     | Multi-Boot USB Engine (Ventoy) | **`$mod + Shift + u`** | Drag-and-drop multiple bootable ISOs |
| **Disk**    | Interactive Storage Explorer | **`$mod + Ctrl + d`** | Arrow-key terminal storage usage (`gdu ~`) |
| **Mobile**  | Android Screen Mirror (Scrcpy)| **`$mod + a`** | 60fps low-latency mirror & PC control |
| **Mobile**  | Universal Android Debloater | **`$mod + Alt + a`** | Safely remove pre-installed bloatware |
| **Mobile**  | Wi-Fi File Drop (Share-WiFi) | **`$mod + Ctrl + w`** | Terminal QR code for wireless file sharing |
| **Screen**  | Full Screenshot (Satty) | **`Print`** | Captured to `~/Pictures/Screenshots` |
| **Screen**  | Area Crop Screenshot (Satty) | **`Shift + Print`** | Select area and annotate directly |
| **Screen**  | Instant Screen OCR (Tesseract)| **`$mod + Shift + o`** or **`Alt + Print`** | Select any area → extracted text to clipboard |
| **Display** | Toggle Night Light | **`$mod + n`** | Eye-care blue light reduction filter |
| **Display** | Cycle Night Light Temperature | **`$mod + Shift + n`** | 4500K -> 3500K -> 2700K -> Off |
| **Display** | Monitor Brightness Up / Down | **`XF86MonBrightnessUp / Down`** | Hardware DDC/CI monitor brightness |
| **Audio**   | Volume Up / Down / Mute | **`Volume Keys`** | Pamixer PipeWire volume routing |
| **Audio**   | Media Play / Pause | **`XF86AudioPlay`** or **`$mod + Alt + p`** | Universal playerctl control |
| **Audio**   | Next / Previous Track | **`$mod + ]`** / **`$mod + [`** | Track skipping |
| **Health**  | Wellbeing Eye Strain Menu | **`$mod + Alt + e`** | 20-20-20 rule & break timer settings |
| **Session** | Lock Screen | **`$mod + Backspace`** or **`$mod + Ctrl + l`** | Secure Wayland swaylock |
| **Session** | Reload Sway Config | **`$mod + Shift + r`** | In-place compositor reload |
| **Session** | Exit Sway Dialog | **`$mod + Shift + e`** | Clean logout confirmation |
| **Window**  | Close / Kill Window | **`$mod + w`** | Terminate active application |
| **Window**  | Toggle Fullscreen | **`$mod + f`** | Dedicated fullscreen container |
| **Window**  | Toggle Floating / Tiling | **`$mod + t`** | Float individual window |
| **Window**  | Window Focus Navigation | **`$mod + Arrows`** or **`$mod + h, j, l, Up`** | Focus window direction |
| **Window**  | Window Move Navigation | **`$mod + Shift + Arrows`** or **`h, j, k, l`** | Move container direction |
| **Layout**  | Vertical / Horizontal Split | **`$mod + v`** / **`$mod + \`** | Set container split orientation |
| **Layout**  | Stacking / Tabbed Layout | **`$mod + s`** / **`$mod + Shift + w`** | Tabbed or stacked container views |
| **Workspaces**| Switch Workspace 1–10 | **`$mod + 1 .. 0`** | Instant workspace switching |
| **Workspaces**| Move Container to Workspace | **`$mod + Shift + 1 .. 0`** | Move window to target workspace |
