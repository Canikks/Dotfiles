# NixOS Dotfiles

A comprehensive, modular NixOS configuration with Home Manager for a modern Wayland-based development environment.

## Overview

This repository contains a complete NixOS system configuration featuring:
- **Window Manager**: Niri (Wayland compositor) with Mango window manager and custom automation scripts
- **Shell**: Zsh with Starship prompt and Fish shell support
- **Terminal**: Ghostty with custom cursor shader
- **Editor**: Helix and Neovim with comprehensive LSP setup
- **File Manager**: Yazi
- **Theme System**: Stylix for consistent theming
- **Package Management**: Nix flakes with multiple community inputs

## Directory Structure

```
dotfiles/
├── flake.nix                    # Main flake configuration with all inputs
├── hardware-configuration.nix   # Auto-generated hardware configuration
├── packages.nix                 # System-wide package definitions
├── README.md                    # This file
│
├── hosts/utkar/                 # Host-specific system configuration
│   └── configuration.nix        # Main system-level config (boot, networking, services)
│
├── home/utkar/                  # User-level Home Manager configuration
│   ├── home.nix                 # Main home manager config
│   ├── home-packages.nix        # Additional user packages
│   ├── editor/helix.nix         # Helix editor configuration
│   ├── file-manager/yazi.nix    # Yazi file manager configuration
│   ├── mango/                   # Mango window manager configuration
│   │   ├── scripts/             # Utility scripts for Mango
│   │   │   ├── brightness.sh    # Screen brightness control
│   │   │   ├── exitdim.sh       # Exit dimming script
│   │   │   ├── hide_waybar_mango.sh # Waybar toggle for Mango
│   │   │   ├── idle.sh          # Idle management
│   │   │   ├── monitor.sh       # Monitor configuration
│   │   │   ├── restart_wlsunset.sh # Wlsunset restart
│   │   │   ├── virmon.sh        # Virtual monitor setup
│   │   │   └── volume.sh        # Audio volume control
│   │   ├── autostart.sh         # Auto-start applications
│   │   ├── bind.conf            # Key bindings configuration
│   │   ├── config.conf          # Main Mango configuration
│   │   ├── env.conf             # Environment variables
│   │   └── rule.conf            # Window rules
│   ├── shell/                   # Shell configuration
│   │   ├── prompt/              # Shell prompt configuration
│   │   │   ├── starship.nix     # Starship prompt Home Manager config
│   │   │   └── starship.toml    # Starship prompt configuration
│   │   └── zsh.nix              # Zsh shell configuration
│   └── terminal/                # Terminal configuration
│       ├── cursor_smear.glsl    # Cursor shader for Ghostty
│       └── ghostty.nix          # Ghostty terminal configuration
│
├── modules/                     # Reusable configuration modules
│   ├── environment.nix          # Environment variables and paths
│   ├── programs.nix             # System-wide program configuration
│   └── services.nix             # System services configuration
│
└── Pictures/                    # Wallpapers and images
    ├── nebula-thumb.jpg
    ├── stars-1654074_1280.jpg
    └── [other wallpapers]
```

## Key Components

### System Configuration (`hosts/utkar/configuration.nix`)
- **Boot**: systemd-boot with CachyOS kernel optimization
- **Networking**: NetworkManager with custom DNS (Cloudflare/Quad9)
- **Timezone**: Asia/Kolkata with en_GB.UTF-8 locale
- **Virtualization**: Podman with Docker compatibility
- **Hardware**: Intel CPU microcode, graphics drivers, Bluetooth
- **Security**: polkit, rtkit, sudo-rs
- **XDG**: Portal support for Wayland (wlr, gtk backends)

### Home Manager Configuration (`home/utkar/home.nix`)
- **Window Manager**: Mango (Wayland) with UWSM integration and custom scripts
- **Shell**: Zsh with Starship prompt and Fish shell support
- **Database**: KeePassXC with auto-start
- **CLI Tools**: Tealdeer with auto-updates, nix-index integration
- **Nix Integration**: Home Manager with backup file extensions

### Mango Window Manager Configuration (`home/utkar/mango/`)
- **Core Configuration**: Window management, key bindings, and environment setup
- **Utility Scripts**: Brightness control, volume management, monitor configuration
- **Automation**: Auto-start applications, idle management, and Waybar integration
- **Window Rules**: Custom rules for application behavior and placement

### Modular Program Configuration (`modules/programs.nix`)
- **Neovim (nvf)**: Comprehensive development setup with:
  - Language support: Nix, Python, Rust, Go, TypeScript, Java, C/C++, and more
  - LSP servers: nixd for Nix, with automatic formatting
  - Debugging: nvim-dap with UI support
  - Theme: Tokyo Night with transparency
  - Plugins: Telescope, Git integration, treesitter, and many more
- **Development Tools**: 
  - Niri compositor, zoxide, bat, git with LFS
  - nh for Nix operations, steam with gaming support
  - Gamescope and Gamemode for Linux gaming

### Environment Setup (`modules/environment.nix`)
- **Editor Variables**: EDITOR and VISUAL set to nvim
- **Wayland**: QML2 import paths, VAAPI drivers
- **Gaming**: Steam native libraries configuration
- **Polkit Rules**: UDisks2 rules for wheel group users
- **Wayland Session**: Custom Niri desktop entry

## Package Sources

The flake includes numerous community inputs:
- `nixpkgs` - NixOS packages (stable channel)
- `unstable-nixpkgs` - NixOS packages (unstable channel)
- `home-manager` - User environment management
- `niri` - Wayland compositor
- `nvf` - Neovim configuration framework
- `stylix` - Theme system
- `ghostty` - Terminal emulator
- `yazi` - File manager
- `chaotic` - Additional packages
- `nur` - Nix User Repository
- And many more development and utility packages

## Usage

### Installation
```bash
# Clone the repository
git clone <repository-url> ~/dotfiles
cd ~/dotfiles

# Build and switch to the configuration
sudo nixos-rebuild switch --flake .#utkar
```

### Development Commands
```bash
# Update all inputs
nix flake update

# Build without switching
nix build .#nixosConfigurations.utkar.config.system.build.toplevel

# Enter the development shell
nix develop

# Clean up old generations
nh clean all
```

### Key Features
- **Modular Design**: Separate files for different concerns
- **Type Safety**: Nix flake configuration with proper typing
- **Reproducible**: Complete environment replication
- **Modern Wayland**: Native Wayland support with Niri
- **Development Focused**: Comprehensive language and tool support
- **Gaming Ready**: Steam, Gamescope, and Gamemode support
- **Theme Consistent**: Stylix provides unified theming

## Customization

To adapt this configuration:
1. Update `hosts/utkar/configuration.nix` for system-level changes
2. Modify `home/utkar/home.nix` for user-level preferences
3. Add new modules in `modules/` for shared configurations
4. Update `flake.nix` to add new inputs or packages
5. Change wallpapers in `Pictures/` directory

This configuration represents a complete, modern Linux desktop environment optimized for development with Wayland technologies.
