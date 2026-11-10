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
| **Clipboard**| **Universal Copy** | **`$mod + c`** | Works across terminal, browser, and all GUI apps |
| **Clipboard**| **Universal Paste** | **`$mod + v`** | Works across terminal, browser, and all GUI apps |
| **Clipboard**| **Push to Phone Bridge** | **`$mod + Ctrl + c`** | Send clipboard text or photo to phone bridge |
| **Clipboard**| Clipboard History (Cliphist) | **`$mod + Shift + v`** | Search, paste, or wipe clipboard |
| **Monitor** | System & Task Monitor (Btop) | **`$mod + Escape`** | CPU, GPU, RAM, Disks, Networks |
| **Browser** | Chromium Browser | **`$mod + b`** | Default Web Browser |
| **Browser** | Brave Origin Nightly | **`$mod + Shift + b`** | Secondary Ad-blocking Browser |
| **Files**   | Graphical File Manager (Thunar)| **`$mod + Shift + f`** | Thunar GUI with MTP phone browsing |
| **Files**   | Terminal File Manager (Yazi) | **`$mod + Alt + f`** | Fast terminal file manager with image previews |
| **PDF**     | Annotate & Sign (Xournal++) | **`$mod + p`** | Lecture notes, PDF highlighting, signing |
| **PDF**     | Split, Merge & Crop (PDF Arranger)| **`$mod + Shift + p`** | Drag & drop PDF page manipulator |
| **Math**    | Scientific Calculator (Galculator)| **`$mod + =`** / **`$mod + Shift + c`** | GTK scientific desktop calculator |
| **Math**    | Physics, Calculus & Currency | `calc "<expr>"` | E.g. `calc "50 USD in INR"`, `calc "2.5 eV in J"` |
| **Image**   | Image Editor & Cropper (Pinta)| **`$mod + i`** | Paint.NET alternative: crop, retouch, layers |
| **Notes**   | Quick GUI Text Notes (Mousepad)| **`$mod + m`** | Fast tabbed text editor with syntax highlighting |
| **Git**     | Interactive Git TUI (LazyGit) | **`$mod + g`** | Stage lines, commit, branch, diffs (`lg`) |
| **USB**     | Disks & ISO Burner (GNOME Disks)| **`$mod + u`** | Format (FAT32/exFAT/NTFS) & flash ISO to USB |
| **USB**     | Multi-Boot USB Engine (Ventoy) | **`$mod + Shift + u`** | Drag-and-drop multiple bootable ISOs |
| **Disk**    | Interactive Storage Explorer | **`$mod + Ctrl + d`** | Arrow-key terminal storage usage (`gdu ~`) |
| **Mobile**  | Android Screen Mirror (Scrcpy)| **`$mod + a`** | 60fps low-latency mirror & PC control |
| **Mobile**  | **Phone Storage in Thunar** | **`$mod + Ctrl + m`** | Wireless phone storage in Thunar (Samsung style) |
| **Mobile**  | **Phone <> PC Clipboard Bridge** | **`$mod + Ctrl + p`** | 2-way phone & PC clipboard sync (Web QR, no app) |
| **Mobile**  | **LocalSend (AirDrop style)** | **`$mod + Alt + l`** | 1-tap open-source wireless file & text share |
| **Mobile**  | Universal Android Debloater | **`$mod + Alt + a`** | Safely remove pre-installed bloatware |
| **Web Apps**| **Google Gemini AI** | **`$mod + Alt + g`** | Google Gemini conversational assistant |
| **Web Apps**| **ChatGPT AI** | **`$mod + Alt + c`** | OpenAI ChatGPT web application |
| **Web Apps**| **Claude AI** | **`$mod + Alt + k`** or **`d`** | Anthropic Claude AI assistant |
| **Web Apps**| **WhatsApp Web** | **`$mod + Alt + w`** | Standalone WhatsApp Web client |
| **Web Apps**| **Gmail** | **`$mod + Alt + m`** | Standalone Gmail inbox client |
| **Web Apps**| YouTube / Music | **`$mod + Shift + y`** / **`m`** | Standalone YouTube & Music players |
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
| **Layout**  | Vertical / Horizontal Split | **`$mod + -`** / **`$mod + \`** | Set container split orientation |
| **Layout**  | Stacking / Tabbed Layout | **`$mod + s`** / **`$mod + Shift + w`** | Tabbed or stacked container views |
| **Workspaces**| Switch Workspace 1–10 | **`$mod + 1 .. 0`** | Instant workspace switching |
| **Workspaces**| Move Container to Workspace | **`$mod + Shift + 1 .. 0`** | Move window to target workspace |

---

## 📱 Wireless Phone <> PC Integration (0 MB Idle RAM)

### 1. View & Browse Whole Phone Storage in Thunar (Wirelessly)
* **How it works:** Uses Thunar's native GVFS network backend over your local Wi-Fi. 0 persistent background daemons, 0 MB idle RAM.
* **On Phone (One-time):**
  1. Install any modern Android file manager with built-in Wi-Fi sharing (e.g. **Material Files** from F-Droid/Play Store, or **Cx File Explorer**, or **Solid Explorer**).
  2. Open the app and tap **"Start FTP Server"** (or "Access from network").
  3. Note the local address shown on your phone screen (e.g., `ftp://192.168.1.15:2121`).
* **On Laptop:**
  1. Press **`$mod + Ctrl + m`** (or run `phone-mount` in terminal).
  2. Enter the phone's address (it remembers it next time, so you only press Enter).
  3. **Done!** Thunar instantly opens your entire phone internal storage (DCIM, Downloads, Documents, Music, Android, etc.) right in the file manager sidebar, exactly like Samsung Quick Share or Link to Windows!
  4. *Pro-Tip:* Right-click the folder in Thunar and select **"Add Bookmark"** — from then on, you can simply click it in Thunar's sidebar anytime your phone server is on!

### 2. 1-Click Clipboard Sharing Between Phone & Laptop
We provide two zero-bloat paths:

#### Option A: Zero Apps Needed on Phone (`phone-clip`)
* **On Laptop:** Press **`$mod + Ctrl + p`**. A terminal card with a local QR code pops up.
* **On Phone:** Open camera or QR scanner and tap the link (e.g., `http://192.168.1.15:8088`).
* **What you see on phone:**
  - **📥 Current Laptop Clipboard:** Tap **"📋 Copy to Phone Clipboard"** to immediately paste on your phone.
  - **📤 Send to Laptop:** Paste or type text on phone and tap **"🚀 Send to Laptop"**. It instantly populates your Arch Sway clipboard (`wl-copy`) and shows a desktop notification preview!

#### Option B: 1-Tap Native Share Menu (`LocalSend`)
* **On Laptop:** Press **`$mod + Alt + l`** (launches `localsend`).
* **On Phone:** Install **LocalSend** (F-Droid / Play Store).
* **Usage:** Highlight any text or select any photo on your phone, tap **Share → LocalSend → Arch Laptop**. Transferred in less than 1 second!

