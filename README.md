# NixOS Dotfiles Configuration

A comprehensive NixOS flake-based configuration with Home Manager integration, designed for reproducibility, performance, and maintainability.

## Overview

This repository contains my personal NixOS configuration using:
- **NixOS Unstable** with Flakes
- **Home Manager** for user environment management  
- **SOPS-Nix** for secrets management
- **Niri** as the primary Wayland compositor
- **Dank Material Shell** for desktop environment

## Features

### Core System
- **Flake-based configuration** with comprehensive inputs management
- **Modular structure** separating host and home configurations
- **SOPS integration** for encrypted secrets management
- **Performance optimizations** for Nix builds and system operations

### Window Management
- **Niri** (primary) and Mango (legacy) Wayland compositors
- **Dank Material Shell** with system monitoring and theming
- **Multiple terminal emulators** (Ghostty, Wezterm, Kitty, Rio)

### Development Environment
- **Devenv** for development shell management
- **Multiple editors** (Helix, Neovim, Zeditor)
- **Comprehensive CLI tools** (eza, bat, fzf, zoxide, etc.)

### System Services
- **Blocky DNS** with caching and ad-blocking
- **PipeWire** for audio with LSP plugins
- **SCX scheduler** with lavd for performance
- **Firewall** with restrictive port configuration

## Getting Started

### Prerequisites
- NixOS system with flakes enabled
- Age encryption keys for SOPS (if using secrets)
- Basic familiarity with Nix language

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://gitlab.com/Canikks/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Apply the configuration:**
   ```bash
   sudo nixos-rebuild switch --flake .#utkar
   ```

3. **Apply Home Manager configuration:**
   ```bash
   home-manager switch --flake .#utkar
   ```

## Usage

### Common Commands

- **Update flake inputs:** `nix flake update` or use alias `nfu`
- **Rebuild system:** `sudo nixos-rebuild switch --flake .#utkar` or use alias `nrs`
- **Enter development environment:** `devenv shell`
- **Format Nix files:** `alejandra .`
- **Check flake:** `nix flake check --impure`

### Development Workflow

1. **Make changes** to configuration files
2. **Test changes** with `nixos-rebuild test`
3. **Apply changes** with `nixos-rebuild switch`
4. **Commit changes** including updated `flake.lock`

## Performance Optimizations

The configuration includes several performance enhancements:

- **Nix build optimizations:**
  - `max-jobs = "auto"` - Utilizes all available CPU cores
  - `cores = 0` and `build-cores = 0` - Uses all cores for builds
  - `compress-build-log = true` - Reduces disk usage
  - Multiple cachix substituters for faster downloads

- **System-level optimizations:**
  - SCX scheduler with lavd for better process scheduling
  - Blocky DNS caching to reduce lookup times
  - Nix daemon configured for idle scheduling

## Update Strategy

### Flake Updates
- Run `nix flake update` periodically to update inputs
- Test changes before applying: `nixos-rebuild test`
- Review `flake.lock` changes before committing

### System Updates
- Major updates should be tested in a VM first
- Consider using generations for easy rollback
- Monitor system after updates for any issues

## Security Considerations

### Current Security Features
- **Firewall** enabled with restrictive port rules
- **Blocky DNS** with security blocklists
- **SOPS** for encrypted secrets management
- **Polkit, rtkit, sudo-rs** for privilege management

### Recommendations for Personal Use
- Keep SSH access restricted if exposed to network
- Regularly update flake inputs
- Review secrets management periodically
- Monitor system logs for unusual activity

## Maintenance Tips

### For Single-Person Maintenance
1. **Keep it simple** - Avoid over-engineering
2. **Document changes** - Add comments for non-obvious configurations
3. **Test regularly** - Especially after major updates
4. **Use generations** - For easy rollback capability
5. **Backup important files** - Especially `flake.lock` and secrets

### Troubleshooting
- **Build failures:** Check `nix log` for specific package issues
- **Configuration errors:** Use `nixos-rebuild dry-activate` to test
- **Performance issues:** Monitor with `htop` and adjust Nix settings
- **Network issues:** Check Blocky and firewall configurations

## License

This configuration is provided as-is for personal use. Feel free to fork and adapt for your own needs.

## Acknowledgments

- NixOS community for excellent documentation
- Home Manager contributors for user environment management
- SOPS-Nix for secure secrets handling
- Various flake input maintainers for their work

## Project Status

Actively maintained for personal use. Updates are made as needed for my specific workflow and hardware configuration.
